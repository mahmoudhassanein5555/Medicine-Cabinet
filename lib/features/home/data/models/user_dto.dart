import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';

class UserDto extends UserEntity {
  const UserDto({
    required super.email,
    required super.householdId,
    required super.name,
    required super.photoUrl,
    required super.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    final rawCreatedAt = json['createdAt'];
    if (rawCreatedAt is Timestamp) {
      parsedDate = rawCreatedAt.toDate();
    } else if (rawCreatedAt is String) {
      parsedDate = DateTime.tryParse(rawCreatedAt) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return UserDto(
      email: json['email'] ?? '',
      householdId: json['householdId'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdAt: parsedDate,
    );
  }

  factory UserDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return UserDto.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'householdId': householdId,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      email: entity.email,
      householdId: entity.householdId,
      name: entity.name,
      photoUrl: entity.photoUrl,
      createdAt: entity.createdAt,
    );
  }
}
