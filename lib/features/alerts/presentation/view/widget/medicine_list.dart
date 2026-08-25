import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/medicine_entity.dart';
import 'empty_medicine_state.dart';
import 'medicine_card.dart';

class MedicineList extends StatelessWidget {
  final List<MedicineEntity> medicines;

  const MedicineList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return const EmptyMedicineState();
    }

    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: medicines.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return MedicineCard(medicine: medicines[index]);
      },
    );
  }
}
