import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';

class MedicineDto extends MedicineEntity {
  MedicineDto({
    required super.id,
    required super.addedBy,
    required super.category,
    required super.createdAt,
    required super.expiryDate,
    required super.imageUrl,
    required super.name,
    required super.ownerId,
    required super.quantity,
    required super.storageLocation,
    required super.type,
    required super.updatedAt,
  });

  static DateTime _parseDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return DateTime.now();
  }

  factory MedicineDto.fromJson(Map<String, dynamic> json, String documentId) {
    return MedicineDto(
      id: documentId,
      addedBy: json['addedBy']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      createdAt: _parseDateTime(json['createdAt']),
      expiryDate: _parseDateTime(json['expiryDate']),
      imageUrl: json['imageUrl']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      ownerId: json['ownerId']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      storageLocation: json['storageLocation']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  factory MedicineDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return MedicineDto.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  Map<String, dynamic> toMap() => toJson();

  factory MedicineDto.fromEntity(MedicineEntity entity) {
    return MedicineDto(
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
    );
  }
}