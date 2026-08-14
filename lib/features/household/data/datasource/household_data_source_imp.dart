import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/household/data/datasource/household_data_source_interface.dart';
import 'package:medicine_cabinet/features/household/data/model/household_model.dart';
@Injectable(as: HouseholdDataSourceInterface)
class HouseholdDataSourceImp implements HouseholdDataSourceInterface {
  final FirebaseFirestore _firestore;

  HouseholdDataSourceImp(this._firestore);
  @override
  Future<HouseholdDto> createHousehold({
    required String name,
    required String userId,
  }) async {
    final householdRef = _firestore.collection('households').doc();
    final household = HouseholdDto(
      id: householdRef.id,
      name: name,
      ownerId: userId,
      memberIds: [userId],
    );
    await householdRef.set(household.toFirestore());
    return household;
  }

  @override
  Future<HouseholdDto?> getUserHousehold({required String userId}) async {
    final querySnapshot = await _firestore
        .collection('households')
        .where('memberIds', arrayContains: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    final doc = querySnapshot.docs.first;

    return HouseholdDto.fromFirestore(doc.data(), doc.id);
  }

  @override
  Future<HouseholdDto> joinHousehold({
    required String householdId,
    required String userId,
  }) async {
    final householdRef = _firestore.collection('households').doc(householdId);
    final householdSnapshot = await householdRef.get();
    if (!householdSnapshot.exists) {
      throw Exception('Household not found');
    }
    await householdRef.update({
      'memberIds': FieldValue.arrayUnion([userId]),
    });
    final updatedSnapshot = await householdRef.get();

    return HouseholdDto.fromFirestore(
      updatedSnapshot.data()!,
      updatedSnapshot.id,
    );
  }
}
