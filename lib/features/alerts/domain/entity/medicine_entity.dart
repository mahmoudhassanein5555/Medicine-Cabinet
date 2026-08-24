class MedicineEntity {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime? expiryDate;
  final DateTime? createdAt;
  final String ownerId;
  final String addedBy;
  final String? imageUrl;
  MedicineEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.ownerId,
    required this.addedBy,
    this.expiryDate,
    this.createdAt,
    this.imageUrl,
  });
  bool get isExpired =>
      expiryDate != null && expiryDate!.isBefore(DateTime.now());

  bool get isAvailable => quantity > 0 && !isExpired;

  bool get isEnded => quantity <= 0;

  bool isRecentlyAdded({int days = 7}) {
    if (createdAt == null) return false;
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return createdAt!.isAfter(cutoff);
  }
}
