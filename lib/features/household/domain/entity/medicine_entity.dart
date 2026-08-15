class MedicineEntity {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime? expiryDate;
  final String ownerId;
  final String addedBy;
  final String? imageUrl;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.ownerId,
    required this.addedBy,
    this.expiryDate,
    this.imageUrl,
  });

  bool get isExpired =>
      expiryDate != null && expiryDate!.isBefore(DateTime.now());
}