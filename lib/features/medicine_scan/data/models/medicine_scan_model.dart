import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';

class MedicineScanModel {
  final String name;
  final String? category;
  final String type;
  final DateTime? expiryDate;
  final String? description;
  final String? imageUrl;

  MedicineScanModel({
    this.name = "",
    this.category,
    this.type = "",
    this.expiryDate,
    this.imageUrl,
    this.description,
  });

  factory MedicineScanModel.fromJson(Map<String, dynamic> json) {
    return MedicineScanModel(
      name: json['name'] as String? ?? '',
      category: json['category'] as String?,
      type: json['type'] as String? ?? '',
      expiryDate: json['expiryDate'] != null
          ? DateTime.tryParse(json['expiryDate'] as String)
          : null,
      description: json['description'] as String?,
    );
  }

  factory MedicineScanModel.fromEntity(MedicineScanEntity entity) {
    return MedicineScanModel(
      name: entity.name,
      category: entity.category,
      type: entity.type,
      expiryDate: entity.expiryDate,
      description: entity.description,
    );
  }

  MedicineScanEntity toEntity() {
    return MedicineScanEntity(
      name: name,
      category: category,
      type: type,
      expiryDate: expiryDate,
      description: description,
      imageUrl: imageUrl
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'type': type,
      'expiryDate': expiryDate?.toIso8601String(),
      'description': description,
    };
  }
}
