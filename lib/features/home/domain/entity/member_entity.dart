class MemberEntity {
  final String id;
  final String name;
  final String role;
  final String photoUrl;
  final DateTime joinedAt;

  const MemberEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.joinedAt,
    this.photoUrl = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  String get firstName {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    return trimmed.split(' ').first;
  }

  String get initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'M';
    return trimmed[0].toUpperCase();
  }
}
