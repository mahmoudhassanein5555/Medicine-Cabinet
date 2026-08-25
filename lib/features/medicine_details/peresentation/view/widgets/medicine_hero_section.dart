import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineHeroSection extends StatelessWidget {
  final MedicineDetailsEntity medicine;

  const MedicineHeroSection({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = S.of(context);

    final details = [
      if (medicine.category?.isNotEmpty == true)
        _getLocalizedCategory(l10n, medicine.category!),
      _getLocalizedType(l10n, medicine.type),
    ].join(' • ');

    return Column(
      children: [
        Container(
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceAltDark
                : AppColors.surfaceAltLight,
            borderRadius: BorderRadius.circular(28.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: medicine.imageUrl.isEmpty
              ? Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 42.r,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                )
              : Image.network(
                  medicine.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.inventory_2_outlined,
                    size: 42.r,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
        ),

        SizedBox(height: 16.h),

        Text(
          medicine.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 22.sp,
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          details,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  String _getLocalizedType(S l10n, String type) {
    switch (type.toLowerCase()) {
      case 'pills':
      case 'tablet':
      case 'tablets':
        return l10n.medicineTypePills;

      case 'syrup':
        return l10n.medicineTypeSyrup;

      case 'capsules':
      case 'capsule':
        return l10n.medicineTypeCapsules;

      case 'drops':
        return l10n.medicineTypeDrops;

      case 'cream':
        return l10n.medicineTypeCream;

      case 'ointment':
        return l10n.medicineTypeOintment;

      case 'inhaler':
      case 'spray':
        return l10n.medicineTypeInhaler;

      default:
        return type;
    }
  }

  String _getLocalizedCategory(S l10n, String category) {
    switch (category.toLowerCase()) {
      case 'pain relief':
        return l10n.medicineCategoryPainRelief;

      case 'cold & flu':
        return l10n.medicineCategoryColdFlu;

      case 'allergy':
        return l10n.medicineCategoryAllergy;

      case 'digestive':
        return l10n.medicineCategoryDigestive;

      case 'vitamins':
        return l10n.medicineCategoryVitamins;

      case 'antibiotics':
        return l10n.medicineCategoryAntibiotics;

      case 'skin care':
        return l10n.medicineCategorySkinCare;

      default:
        return category;
    }
  }
}
