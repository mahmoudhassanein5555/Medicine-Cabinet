import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/date_formatter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/screens/medicine_details_screen.dart';

class MedicinesList extends StatelessWidget {
  final List<MedicineEntity> medicines;
  final String householdId;

  const MedicinesList({
    super.key,
    required this.medicines,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      sliver: SliverList.separated(
        itemCount: medicines.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final medicine = medicines[index];

          return MedicineCard(
            imageUrl: medicine.imageUrl,
            name: medicine.name,
            type: medicine.type,
            remaining: medicine.quantity,
            expiry: formatExpiryDate(context, medicine.expiryDate),
            addedBy: medicine.addedBy,
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
      ),
    );
  }
}
