import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/core/errors/error.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source.dart';
import 'package:medicine_cabinet/features/home/data/models/medicine_dto.dart';
import 'package:medicine_cabinet/features/home/data/models/member_dto.dart';
import 'package:medicine_cabinet/features/home/data/models/user_dto.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;

  HomeRemoteDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserDto> getUserDetails(String userId) async {
    final docSnapshot = await _firestore.collection('users').doc(userId).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw RemoteException('');
    }

    return UserDto.fromFirestore(docSnapshot);
  }

  @override
  Future<List<MedicineDto>> getHouseholdMedicines(String householdId) async {
    final querySnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .get();

    return querySnapshot.docs
        .map((doc) => MedicineDto.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<MemberDto>> getHouseholdMembers(String householdId) async {
    final querySnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('members')
        .get();

    return querySnapshot.docs
        .map((doc) => MemberDto.fromFirestore(doc))
        .toList();
  }
}
