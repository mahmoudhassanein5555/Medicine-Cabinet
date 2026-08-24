import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicinesLoading extends StatelessWidget {
  const MedicinesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      sliver: SliverList.separated(
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 11),
        itemBuilder: (context, index) {
          return Skeletonizer(
            enabled: true,
            child: MedicineCard(
              name: AppStrings.dummyMedicineName,
              type: AppStrings.dummyMedicineType,
              remaining: 12,
              expiry: AppStrings.dummyMedicineExpiry,
              addedBy: AppStrings.dummyMedicineAddedBy,
              status: AppStrings.dummyMedicineStatus,
            ),
          );
        },
      ),
    );
  }
}
