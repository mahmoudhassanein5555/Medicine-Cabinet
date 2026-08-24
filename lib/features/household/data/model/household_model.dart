import '../../domain/entity/household_entity.dart';

class HouseholdDto {
  final String id;
  final String name;
  final String createdBy;

  HouseholdDto({
    required this.id,
    required this.name,
    required this.createdBy,
  });

  factory HouseholdDto.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {
    return HouseholdDto(
      id: documentId,
      name: data['name'] ?? '',
      createdBy: data['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'createdBy': createdBy,
    };
  }

  HouseholdEntity toEntity() {
    return HouseholdEntity(
      id: id,
      name: name,
      createdBy: createdBy,
    );
  }
}