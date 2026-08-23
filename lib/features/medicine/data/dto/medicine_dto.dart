import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';

class MedicineDto {
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

  const MedicineDto({
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

  factory MedicineDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return MedicineDto(
      id: doc.id,
      name: data['name'] as String,
      type: data['type'] as String,
      quantity: data['quantity'] as int,
      expiryDate: (data['expiryDate'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'] as String?,
      ownerId: data['ownerId'] as String,
      addedBy: data['addedBy'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
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
    };
  }
}
