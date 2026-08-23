class MedicineEntity {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime expiryDate;
  final String? imageUrl;
  final String ownerId;
  final String addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.expiryDate,
    this.imageUrl,
    required this.ownerId,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });
}
