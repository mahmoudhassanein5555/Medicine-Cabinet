import '../../domain/entity/household_member_entity.dart';

class HouseholdMemberDto {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String role;

  HouseholdMemberDto({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
  });

  factory HouseholdMemberDto.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {
    return HouseholdMemberDto(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      role: data['role'] ?? 'member',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
    };
  }

  HouseholdMemberEntity toEntity() {
    return HouseholdMemberEntity(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      role: role,
    );
  }
}