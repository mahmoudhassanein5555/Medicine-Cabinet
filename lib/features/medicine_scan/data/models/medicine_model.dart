import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';

class MedicineModel {
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
  final String description;

  MedicineModel({
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
    required this.description,
  });

  factory MedicineModel.fromEntity(MedicineEntity entity) {
    return MedicineModel(
      id: entity.id,
      addedBy: entity.addedBy,
      category: entity.category,
      createdAt: entity.createdAt,
      expiryDate: entity.expiryDate,
      imageUrl: entity.imageUrl,
      name: entity.name,
      ownerId: entity.ownerId,
      quantity: entity.quantity,
      storageLocation: entity.storageLocation,
      type: entity.type,
      updatedAt: entity.updatedAt,
      description: entity.description,
    );
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      addedBy: addedBy,
      category: category,
      createdAt: createdAt,
      expiryDate: expiryDate,
      imageUrl: imageUrl,
      name: name,
      ownerId: ownerId,
      quantity: quantity,
      storageLocation: storageLocation,
      type: type,
      updatedAt: updatedAt,
      description: description,
    );
  }

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] as String? ?? '',
      addedBy: json['addedBy'] as String? ?? '',
      category: json['category'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      expiryDate: (json['expiryDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: json['imageUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      storageLocation: json['storageLocation'] as String? ?? '',
      type: json['type'] as String? ?? '',
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addedBy': addedBy,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'expiryDate': Timestamp.fromDate(expiryDate),
      'imageUrl': imageUrl,
      'name': name,
      'ownerId': ownerId,
      'quantity': quantity,
      'storageLocation': storageLocation,
      'type': type,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'description': description,
    };
  }
}
