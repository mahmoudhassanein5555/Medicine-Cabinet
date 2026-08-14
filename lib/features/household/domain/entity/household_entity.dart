class HouseholdEntity {
  final String id;
  final String name;
  final String ownerId;
  final List<String> memberIds;

  const HouseholdEntity({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.memberIds,
  });
}