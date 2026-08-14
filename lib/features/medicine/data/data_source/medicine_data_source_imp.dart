import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/medicine/data/data_source/medicine_data_source_interface.dart';
import 'package:medicine_cabinet/features/medicine/data/dto/medicine_dto.dart';

@LazySingleton(as: MedicineDataSourceInterface)
class MedicineDataSourceImpl implements MedicineDataSourceInterface {
  final FirebaseFirestore firestore;

  MedicineDataSourceImpl(this.firestore);

  @override
  Future<List<MedicineDto>> getMedicines() async {
    final snapshot = await firestore.collection('medicines').get();

    return snapshot.docs.map((doc) => MedicineDto.fromFirestore(doc)).toList();
  }
}
