import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel({
    required super.id,
    required super.email,
    required super.joinedAt,
    required super.name,
    required super.photoUrl,
    required super.role,
  });

  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return MemberModel(
      id: doc.id,
      email: data['email'] ?? '',
      joinedAt: (data['joinedAt'] as Timestamp).toDate(),
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'joinedAt': Timestamp.fromDate(joinedAt),
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
    };
  }
}
