class MedicineDetailsEntity {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime expiryDate;
  final String imageUrl;
  final String ownerId;
  final String addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? category;
  final String? storageLocation;

  const MedicineDetailsEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.expiryDate,
    required this.imageUrl,
    required this.ownerId,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.storageLocation,
  });

  MedicineDetailsEntity copyWith({
    String? id,
    String? name,
    String? type,
    int? quantity,
    DateTime? expiryDate,
    String? imageUrl,
    String? ownerId,
    String? addedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? storageLocation,
  }) {
    return MedicineDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      expiryDate: expiryDate ?? this.expiryDate,
      imageUrl: imageUrl ?? this.imageUrl,
      ownerId: ownerId ?? this.ownerId,
      addedBy: addedBy ?? this.addedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      storageLocation: storageLocation ?? this.storageLocation,
    );
  }
}
