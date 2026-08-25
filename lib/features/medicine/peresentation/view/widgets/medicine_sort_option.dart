import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';

class MedicineSortOption extends StatelessWidget {
  final String title;
  final MedicineSort value;
  final MedicineSort selectedValue;
  final VoidCallback onTap;

  const MedicineSortOption({
    super.key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = value == selectedValue;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 47.h,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.dividerColor)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_rounded,
                size: 20.r,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
