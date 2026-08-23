import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/feature/medicine_details/data/data_source/medicine_details_data_source_interface.dart';
import 'package:medicine_cabinet/feature/medicine_details/data/dto/medicine_dto.dart';

@LazySingleton(as: MedicineDetailsDataSourceInterface)
class MedicineDetailsDataSourceImp
    implements MedicineDetailsDataSourceInterface {
  final FirebaseFirestore firestore;

  MedicineDetailsDataSourceImp({required this.firestore});

  CollectionReference<Map<String, dynamic>> _getMedicinesCollection(
    String householdId,
  ) {
    return firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines');
  }

  @override
  Future<MedicineDetailsDto> getMedicineDetails({
    required String householdId,
    required String medicineId,
  }) async {
    final doc = await _getMedicinesCollection(
      householdId,
    ).doc(medicineId).get();

    if (!doc.exists) {
      throw Exception('Medicine not found');
    }

    return MedicineDetailsDto.fromFirestore(doc);
  }

  @override
  Future<void> updateMedicineQuantity({
    required String householdId,
    required String medicineId,
    required int quantity,
  }) async {
    await _getMedicinesCollection(householdId).doc(medicineId).update({
      'quantity': quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> editMedicineDetails({
    required String householdId,
    required String medicineId,
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
    required String? description,
  }) async {
    await _getMedicinesCollection(householdId).doc(medicineId).update({
      'name': name,
      'type': type,
      'category': category,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'storageLocation': storageLocation,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteMedicine({
    required String householdId,
    required String medicineId,
  }) async {
    await _getMedicinesCollection(householdId).doc(medicineId).delete();
  }
}
