import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';

enum AlertCategory { expiry, lowStock, recentlyAdded }

class AlertEntity {
  final MedicineEntity medicine;
  final AlertCategory category;
  final DateTime alertDate;

  AlertEntity({
    required this.medicine,
    required this.category,
    required this.alertDate,
  });
}
