import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineDescriptionSection extends StatelessWidget {
  const MedicineDescriptionSection({super.key, required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    if (description == null || description!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.medicineDetailsDescription,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
