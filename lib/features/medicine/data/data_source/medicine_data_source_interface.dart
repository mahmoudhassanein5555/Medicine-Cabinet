import 'package:medicine_cabinet/features/medicine/data/dto/medicine_dto.dart';

abstract class MedicineDataSourceInterface {
  Future<List<MedicineDto>> getMedicines();
}
