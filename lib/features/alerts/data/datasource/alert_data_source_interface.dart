import 'package:medicine_cabinet/features/alerts/data/model/medicine_model.dart';

abstract class AlertDataSourceInterface {
  Future<List<MedicineDto>>getHouseholdMedicines({
    required String householdId,
});
}