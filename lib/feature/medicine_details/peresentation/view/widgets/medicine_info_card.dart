// import 'package:flutter/material.dart';

// class MedicineDetailsInfoCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const MedicineDetailsInfoCard({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     return Card(
//       elevation: 0,
//       margin: EdgeInsets.zero,
//       color: colors.surface,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: colors.outline),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 38,
//               height: 38,
//               decoration: BoxDecoration(
//                 color: colors.primary.withValues(alpha: 0.10),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, size: 20, color: colors.primary),
//             ),

//             const SizedBox(height: 12),

//             Text(
//               label,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: colors.onSurfaceVariant,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),

//             const SizedBox(height: 5),

//             Text(
//               value,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: theme.textTheme.bodyLarge?.copyWith(
//                 color: colors.onSurface,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class MedicineInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isFullWidth;

  const MedicineInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
