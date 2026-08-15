import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/medicine_entity.dart';

class MedicineDto {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final DateTime? expiryDate;
  final String ownerId;
  final String addedBy;
  final String? imageUrl;

  MedicineDto({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.ownerId,
    required this.addedBy,
    this.expiryDate,
    this.imageUrl,
  });

  factory MedicineDto.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {
    final expiry = data['expiryDate'];
    return MedicineDto(
      id: documentId,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      quantity: (data['quantity'] ?? 0) as int,
      ownerId: data['ownerId'] ?? '',
      addedBy: data['addedBy'] ?? '',
      expiryDate: expiry is Timestamp ? expiry.toDate() : null,
      imageUrl: data['imageUrl'],
    );
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      name: name,
      type: type,
      quantity: quantity,
      ownerId: ownerId,
      addedBy: addedBy,
      expiryDate: expiryDate,
      imageUrl: imageUrl,
    );
  }
}