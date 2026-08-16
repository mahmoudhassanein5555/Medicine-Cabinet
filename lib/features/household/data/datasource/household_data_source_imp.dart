import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/household_member_model.dart';
import '../model/household_model.dart';
import '../model/medicine_model.dart';
import 'household_data_source_interface.dart';

@Injectable(as: HouseholdDataSourceInterface)
class HouseholdDataSourceImp implements HouseholdDataSourceInterface {
  final FirebaseFirestore _firestore;

  HouseholdDataSourceImp(this._firestore);

  @override
  Future<HouseholdDto> createHousehold({
    required String name,
    required String userId,
  }) async {
    final trimmedName = name.trim();

    final householdRef = _firestore.collection('households').doc(trimmedName);

    final existingSnapshot = await householdRef.get();
    if (existingSnapshot.exists) {
      throw Exception(
        'A household with this name already exists, please choose another name',
      );
    }

    final userRef = _firestore.collection('users').doc(userId);
    final memberRef = householdRef.collection('members').doc(userId);
    final userSnapshot = await userRef.get();
    if (!userSnapshot.exists) {
      throw Exception('User not found');
    }
    final userData = userSnapshot.data();
    if (userData == null) {
      throw Exception('User data not found');
    }

    final now = Timestamp.now();
    final batch = _firestore.batch();

    batch.set(householdRef, {
      'name': trimmedName,
      'createdBy': userId,
      'createdAt': now,
    });

    batch.set(memberRef, {
      'name': userData['name'] ?? '',
      'email': userData['email'] ?? '',
      'photoUrl': userData['photoUrl'],
      'role': 'admin',
      'joinedAt': now,
    });

    batch.set(userRef, {
      'householdId': householdRef.id,
    }, SetOptions(merge: true));

    await batch.commit();

    return HouseholdDto(
      id: householdRef.id,
      name: trimmedName,
      createdBy: userId,
    );
  }

  @override
  Future<HouseholdDto?> getUserHousehold({required String userId}) async {
    final userSnapshot = await _firestore.collection('users').doc(userId).get();
    if (!userSnapshot.exists) return null;

    final userData = userSnapshot.data();
    if (userData == null) return null;

    final householdId = userData['householdId'];
    if (householdId == null || householdId.toString().isEmpty) return null;

    final householdSnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .get();

    if (!householdSnapshot.exists) return null;

    return HouseholdDto.fromFirestore(
      householdSnapshot.data()!,
      householdSnapshot.id,
    );
  }

  @override
  Future<HouseholdDto> joinHousehold({
    required String householdId,
    required String userId,
  }) async {
    final householdRef = _firestore.collection('households').doc(householdId);
    final userRef = _firestore.collection('users').doc(userId);
    final memberRef = householdRef.collection('members').doc(userId);

    final userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      throw Exception('User not found');
    }

    final userData = userSnapshot.data();

    if (userData == null) {
      throw Exception('User data not found');
    }
    final householdSnapshot = await householdRef.get();
    if (!householdSnapshot.exists) {
      throw Exception('Household not found');
    }

    final now = Timestamp.now();
    final batch = _firestore.batch();

    batch.set(memberRef, {
      'name': userData['name'] ?? '',
      'email': userData['email'] ?? '',
      'photoUrl': userData['photoUrl'],
      'role': 'member',
      'joinedAt': now,
    });

    batch.set(userRef, {'householdId': householdId}, SetOptions(merge: true));

    await batch.commit();

    return HouseholdDto.fromFirestore(
      householdSnapshot.data()!,
      householdSnapshot.id,
    );
  }

  @override
  Future<List<HouseholdMemberDto>> getHouseholdMembers({
    required String householdId,
  }) async {
    final membersSnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('members')
        .get();

    final medicinesSnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .get();

    final List<HouseholdMemberDto> members = [];

    for (final memberDoc in membersSnapshot.docs) {
      final userId = memberDoc.id;
      final memberData = memberDoc.data();

      final medicineCount = medicinesSnapshot.docs
          .where((medicine) => medicine.data()['ownerId'] == userId)
          .length;

      members.add(
        HouseholdMemberDto(
          id: userId,
          name: memberData['name'] ?? '',
          email: memberData['email'] ?? '',
          photoUrl: memberData['photoUrl'],
          role: memberData['role'] ?? 'member',
          medicineCount: medicineCount,
        ),
      );
    }

    return members;
  }

  @override
  Future<List<MedicineDto>> getMemberMedicines({
    required String householdId,
    required String userId,
  }) async {
    final medicinesSnapshot = await _firestore
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .where('ownerId', isEqualTo: userId)
        .get();

    var resalt = medicinesSnapshot.docs
        .map((doc) => MedicineDto.fromFirestore(doc.data(), doc.id))
        .toList();

    return resalt;
  }
}
