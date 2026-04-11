enum PassType { day, monthly, annual }

class Pass {
  final PassType type;
  final DateTime startDate;
  final DateTime expirationDate;

  Pass({
    required this.type,
    required this.startDate,
    required this.expirationDate,
  });
}