import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';

class MedicineDetailsDto {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime expiryDate;
  final String imageUrl;
  final String ownerId;
  final String? ownerName;
  final String addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? category;
  final String? storageLocation;

  const MedicineDetailsDto({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.expiryDate,
    required this.imageUrl,
    required this.ownerId,
    this.ownerName,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.storageLocation,
  });

  factory MedicineDetailsDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return MedicineDetailsDto(
      id: doc.id,
      name: data['name'] as String? ?? '',
      type: data['type'] as String? ?? '',
      quantity: data['quantity'] as int? ?? 0,
      expiryDate:
          (data['expiryDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: data['imageUrl'] as String? ?? '',
      ownerId: data['ownerId'] as String? ?? '',
      ownerName: data['ownerName'] as String?,
      addedBy: data['addedBy'] as String? ?? '',
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] as String?,
      storageLocation: data['storageLocation'] as String?,
    );
  }

  MedicineDetailsEntity toEntity() {
    return MedicineDetailsEntity(
      id: id,
      name: name,
      type: type,
      quantity: quantity,
      expiryDate: expiryDate,
      imageUrl: imageUrl,
      ownerId: ownerId,
      ownerName: ownerName,
      addedBy: addedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      category: category,
      storageLocation: storageLocation,
    );
  }
}
