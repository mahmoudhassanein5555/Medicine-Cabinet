import '../../domain/entity/household_member_entity.dart';

class HouseholdMemberDto {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String role;
  final int medicineCount;

  HouseholdMemberDto({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    required this.medicineCount,
  });

  HouseholdMemberEntity toEntity() {
    return HouseholdMemberEntity(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      role: role,
      medicineCount: medicineCount,
    );
  }
}