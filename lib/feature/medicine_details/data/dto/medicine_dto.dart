import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';

class MedicineDetailsDto {
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
  final String? storageLocation;
  final String? category;
  final String? description;
  const MedicineDetailsDto({
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
    this.storageLocation,
    this.category,
    this.description,
  });

  factory MedicineDetailsDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return MedicineDetailsDto(
      id: doc.id,
      name: data['name'] as String? ?? '',
      type: data['type'] as String? ?? '',
      quantity: (data['quantity'] as num?)?.toInt() ?? 0,

      expiryDate: (data['expiryDate'] as Timestamp).toDate(),

      imageUrl: data['imageUrl'] as String? ?? '',
      ownerId: data['ownerId'] as String? ?? '',
      addedBy: data['addedBy'] as String? ?? '',

      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),

      storageLocation: data['storageLocation'] as String?,
      category: data['category'] as String?,
      description: data['description'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'type': type,
      'quantity': quantity,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'imageUrl': imageUrl,
      'ownerId': ownerId,
      'addedBy': addedBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'storageLocation': storageLocation,
      'category': category,
      'description': description,
    };
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
      addedBy: addedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      storageLocation: storageLocation,
      category: category,
      description: description,
    );
  }

  factory MedicineDetailsDto.fromEntity(MedicineDetailsEntity entity) {
    return MedicineDetailsDto(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      quantity: entity.quantity,
      expiryDate: entity.expiryDate,
      imageUrl: entity.imageUrl,
      ownerId: entity.ownerId,
      addedBy: entity.addedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      storageLocation: entity.storageLocation,
      category: entity.category,
      description: entity.description,
    );
  }
}
