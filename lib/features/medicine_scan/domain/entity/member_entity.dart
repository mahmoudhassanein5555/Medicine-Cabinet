class MemberEntity {
  final String id;
  final String email;
  final DateTime joinedAt;
  final String name;
  final String photoUrl;
  final String role;

  MemberEntity({
    required this.id,
    required this.email,
    required this.joinedAt,
    required this.name,
    required this.photoUrl,
    required this.role,
  });
}
