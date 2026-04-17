class Bike {
  final String id;
  final String status; // e.g., "available", "rented", "maintenance"
  final String stationId;
  final String slotId;

  Bike({
    required this.id,
    required this.status,
    required this.stationId,
    required this.slotId,
  });

  @override
  String toString() {
    return 'Bike(id: $id, status: $status, stationId: $stationId, slotId: $slotId)';
  }
}
