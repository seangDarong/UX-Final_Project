enum BikeStationStatus { available, empty }

class BikeStation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int availableBikes;

  BikeStation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.availableBikes,

  });

  BikeStationStatus get status => availableBikes > 0
      ? BikeStationStatus.available
      : BikeStationStatus.empty;

  bool get hasAvailableBikes => availableBikes > 0;

  @override
  String toString() {
    return 'BikeStation(id: $id, name: $name, lat: $latitude, lon: $longitude, '
        'availableBikes: $availableBikes)';
  }
}
