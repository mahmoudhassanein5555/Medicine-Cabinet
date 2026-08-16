import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineExpiryBanner extends StatelessWidget {
  final MedicineDetailsEntity medicine;

  const MedicineExpiryBanner({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    final today = DateTime.now();

    final expiry = DateTime(
      medicine.expiryDate.year,
      medicine.expiryDate.month,
      medicine.expiryDate.day,
    );

    final currentDay = DateTime(today.year, today.month, today.day);

    final daysLeft = expiry.difference(currentDay).inDays;

    late final Color foreground;
    late final Color background;
    late final IconData icon;
    late final String status;

    if (daysLeft < 0) {
      foreground = colors.error;
      background = colors.errorContainer;
      icon = Icons.error_outline_rounded;
      status = s.commonExpired;
    } else if (daysLeft <= 30) {
      foreground = colors.tertiary;
      background = colors.surfaceContainerHighest;
      icon = Icons.warning_amber_rounded;
      status = s.commonExpiringSoon;
    } else {
      foreground = colors.primary;
      background = colors.primaryContainer;
      icon = Icons.check_circle_outline_rounded;
      status = s.commonHealthy;
    }

    final date = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(medicine.expiryDate);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: foreground, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${s.commonExpiryDate}: $date',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicine_cabinet/core/constants/app_colors.dart';
// import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
// import 'package:medicine_cabinet/generated/l10n.dart';

// class MedicineExpiryBanner extends StatelessWidget {
//   final MedicineDetailsEntity medicine;

//   const MedicineExpiryBanner({super.key, required this.medicine});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final l10n = S.of(context);

//     final today = DateTime.now();
//     final expiry = DateTime(
//       medicine.expiryDate.year,
//       medicine.expiryDate.month,
//       medicine.expiryDate.day,
//     );
//     final currentDay = DateTime(today.year, today.month, today.day);
//     final daysLeft = expiry.difference(currentDay).inDays;

//     late final Color textColor;
//     late final Color backgroundColor;
//     late final IconData icon;
//     late final String title;

//     if (daysLeft < 0) {
//       textColor = isDark ? AppColors.errorDark : AppColors.errorLight;
//       backgroundColor = isDark
//           ? AppColors.surfaceAltDark
//           : AppColors.errorContainerLight;
//       icon = Icons.error_outline_rounded;
//       title = l10n.commonExpired;
//     } else if (daysLeft <= 30) {
//       textColor = isDark ? AppColors.warningDark : AppColors.warningLight;
//       backgroundColor = isDark
//           ? AppColors.surfaceAltDark
//           : AppColors.warningContainerLight;
//       icon = Icons.warning_amber_rounded;
//       title = l10n.commonExpiringSoon;
//     } else {
//       textColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
//       backgroundColor = isDark
//           ? AppColors.surfaceAltDark
//           : AppColors.primaryContainerLight;
//       icon = Icons.check_circle_outline_rounded;
//       title = l10n.commonHealthy;
//     }

//     final formattedDate = DateFormat.yMMM(
//       Localizations.localeOf(context).toString(),
//     ).format(medicine.expiryDate);

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(icon, color: textColor, size: 24),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     color: textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Expires $formattedDate — in $daysLeft days',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: textColor.withOpacity(0.85),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
