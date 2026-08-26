class MedicineEntity {
  final String id; 
  final String addedBy;
  final String category;
  final DateTime createdAt;
  final DateTime expiryDate;
  final String imageUrl;
  final String name;
  final String ownerId;
  final int quantity;
  final String storageLocation;
  final String type;
  final DateTime updatedAt;

  MedicineEntity({
    required this.id,
    required this.addedBy,
    required this.category,
    required this.createdAt,
    required this.expiryDate,
    required this.imageUrl,
    required this.name,
    required this.ownerId,
    required this.quantity,
    required this.storageLocation,
    required this.type,
    required this.updatedAt,
  });

  bool get isExpired => expiryDate.isBefore(DateTime.now());
  bool get isEnded => quantity <= 0;
  bool get isLowStock => quantity <= 0;
  bool get isRecentlyAdded => DateTime.now().difference(createdAt).inDays <= 3;
}