import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/alerts/data/model/medicine_model.dart';

import 'alert_data_source_interface.dart';

@Injectable(as: AlertDataSourceInterface)
class AlertDataSourceImp implements AlertDataSourceInterface {
  final FirebaseFirestore _firestore;
  AlertDataSourceImp(this._firestore);
  @override
  Future<List<MedicineDto>> getHouseholdMedicines({
    required String householdId,
  }) async {
    final medicinesSnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .get();
    return medicinesSnapshot.docs
        .map((doc) => MedicineDto.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
