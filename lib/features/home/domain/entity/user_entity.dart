class UserEntity {
  final String email;
  final String householdId;
  final String name;
  final String photoUrl;
  final DateTime createdAt;

  const UserEntity({
    required this.email,
    required this.householdId,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
  });

  String get firstName {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    return trimmed.split(' ').first;
  }

  String get initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
    return trimmed[0].toUpperCase();
  }
}