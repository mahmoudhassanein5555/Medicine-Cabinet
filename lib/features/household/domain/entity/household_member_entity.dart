class HouseholdMemberEntity {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String role;
  final int medicineCount;

  const HouseholdMemberEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    required this.medicineCount,
  });
}