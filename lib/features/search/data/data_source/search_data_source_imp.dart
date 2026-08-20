import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/medicine/data/dto/medicine_dto.dart';
import 'package:medicine_cabinet/features/search/data/data_source/search_data_source_interface.dart';

@Injectable(as: SearchDataSourceInterface)
class SearchDataSourceImpl implements SearchDataSourceInterface {
  final FirebaseFirestore firestore;

  SearchDataSourceImpl(this.firestore);

  @override
  Future<List<MedicineDto>> searchMedicines({
    required String householdId,
    required String query,
  }) async {
    final searchQuery = query.trim().toLowerCase();

    final snapshot = await firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .get();

    return snapshot.docs
        .map((doc) => MedicineDto.fromFirestore(doc))
        .where(
          (medicine) => medicine.name.toLowerCase().startsWith(searchQuery),
        )
        .toList();
  }
}
