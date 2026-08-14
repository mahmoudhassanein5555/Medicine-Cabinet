import '../../domain/entity/household_entity.dart';

class HouseholdDto {
  final String id;
  final String name;
  final String ownerId;
  final List<String> memberIds;

  HouseholdDto({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.memberIds,
  });

  factory HouseholdDto.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {
    return HouseholdDto(
      id: documentId,
      name: data['name'] ?? '',
      ownerId: data['ownerId'] ?? '',
      memberIds: List<String>.from(data['memberIds'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ownerId': ownerId,
      'memberIds': memberIds,
    };
  }

  HouseholdEntity toEntity() {
    return HouseholdEntity(
      id: id,
      name: name,
      ownerId: ownerId,
      memberIds: memberIds,
    );
  }
}