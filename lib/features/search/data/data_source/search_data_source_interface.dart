import 'package:medicine_cabinet/features/medicine/data/dto/medicine_dto.dart';

abstract class SearchDataSourceInterface {
  Future<List<MedicineDto>> searchMedicines({
    required String householdId,
    required String query,
  });
}
