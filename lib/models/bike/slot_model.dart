class BikeSlot {
  final String? bikeId; // null if slot is empty
  final String status; // e.g., "available", "empty", "maintenance"

  BikeSlot({
    required this.bikeId,
    required this.status,
  });

  @override
  String toString() {
    return 'BikeSlot(bikeId: $bikeId, status: $status)';
  }
}
