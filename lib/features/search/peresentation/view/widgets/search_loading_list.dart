import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchLoadingList extends StatelessWidget {
  const SearchLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, index) {
          return MedicineCard(
            name: AppStrings.dummyMedicineName,
            type: AppStrings.dummyMedicineType,
            remaining: 12,
            expiry: AppStrings.dummyMedicineExpiry,
            addedBy: AppStrings.dummyMedicineAddedBy,
            status: AppStrings.dummyMedicineStatus,
          );
        },
      ),
    );
  }
}
