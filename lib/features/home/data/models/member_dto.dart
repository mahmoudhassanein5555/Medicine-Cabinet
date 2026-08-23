import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';

class MemberDto extends MemberEntity {
  const MemberDto({
    required super.id,
    required super.name,
    required super.role,
    required super.joinedAt,
    super.photoUrl = '',
  });

  factory MemberDto.fromJson(Map<String, dynamic> json, String id) {
    return MemberDto(
      id: id,
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      photoUrl: json['photoUrl']?.toString() ?? '',
      joinedAt: (json['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(), 
    );
  }

  factory MemberDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return MemberDto.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'photoUrl': photoUrl,
      'joinedAt': Timestamp.fromDate(joinedAt), 
    };
  }

  factory MemberDto.fromEntity(MemberEntity entity) {
    return MemberDto(
      id: entity.id,
      name: entity.name,
      role: entity.role,
      photoUrl: entity.photoUrl,
      joinedAt: entity.joinedAt,
    );
  }
}