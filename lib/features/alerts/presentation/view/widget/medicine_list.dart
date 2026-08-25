import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/screens/medicine_details_screen.dart';

import '../../../domain/entity/medicine_entity.dart';
import 'empty_medicine_state.dart';
import 'medicine_card.dart';

class MedicineList extends StatelessWidget {
  final List<MedicineEntity> medicines;
  final String householdId;

  const MedicineList({
    super.key,
    required this.medicines,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return const EmptyMedicineState();
    }

    return ListView.separated(
      padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
      itemCount: medicines.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return MedicineCard(
          medicine: medicine,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineDetailsScreen(
                  householdId: householdId,
                  medicineId: medicine.id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
