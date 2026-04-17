import 'package:ux_final_project/models/bike/slot_model.dart';

enum StationStatus { available, empty }

class Station {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int capacity;
  final Map<String, BikeSlot> slots;

  Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.capacity,
    required this.slots,
  });

  int get availableBikes {
    return slots.values.where((slot) => slot.status == 'available').length;
  }

  StationStatus get status =>
      availableBikes > 0 ? StationStatus.available : StationStatus.empty;

  bool get hasAvailableBikes => availableBikes > 0;

  @override
  String toString() {
    return 'BikeStation(id: $id, name: $name, lat: $latitude, lon: $longitude, '
        'availableBikes: $availableBikes)';
  }
}
