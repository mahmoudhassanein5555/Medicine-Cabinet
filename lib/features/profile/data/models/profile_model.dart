import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.photoUrl,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}