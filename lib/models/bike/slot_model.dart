class BikeSlot {
  final String? bikeId;
  final String status;

  BikeSlot({
    required this.bikeId,
    required this.status,
  });

  @override
  String toString() {
    return 'BikeSlot(bikeId: $bikeId, status: $status)';
  }
}
