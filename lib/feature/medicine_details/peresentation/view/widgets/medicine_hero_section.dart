// import 'package:flutter/material.dart';

// import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';

// class MedicineHeroSection extends StatelessWidget {
//   final MedicineDetailsEntity medicine;

//   const MedicineHeroSection({super.key, required this.medicine});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     return Column(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//             color: colors.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: medicine.imageUrl.isEmpty
//               ? Icon(
//                   Icons.medication_outlined,
//                   size: 55,
//                   color: colors.onSurfaceVariant,
//                 )
//               : Image.network(
//                   medicine.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) {
//                     return Icon(
//                       Icons.medication_outlined,
//                       size: 55,
//                       color: colors.onSurfaceVariant,
//                     );
//                   },
//                 ),
//         ),
//         const SizedBox(height: 18),
//         Text(
//           medicine.name,
//           textAlign: TextAlign.center,
//           style: theme.textTheme.headlineMedium?.copyWith(
//             color: colors.onSurface,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           [
//             if (medicine.category?.isNotEmpty == true) medicine.category!,
//             medicine.type,
//           ].join(' • '),
//           textAlign: TextAlign.center,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: colors.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
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
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceAltDark
                : AppColors.surfaceAltLight,
            borderRadius: BorderRadius.circular(28),
          ),
          clipBehavior: Clip.antiAlias,
          child: medicine.imageUrl.isEmpty
              ? Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 42,
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
                    size: 42,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
        ),

        const SizedBox(height: 16),

        Text(
          medicine.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          details,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
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
        return l10n.medicineTypePills;

      case 'syrup':
        return l10n.medicineTypeSyrup;

      case 'capsules':
        return l10n.medicineTypeCapsules;

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

      default:
        return category;
    }
  }
}
