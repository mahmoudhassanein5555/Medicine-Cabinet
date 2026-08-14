class MedicineEntity {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime? expiryDate;
  final String ownerId;
  final String addedBy;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.ownerId,
    required this.addedBy,
    this.expiryDate,
  });
}