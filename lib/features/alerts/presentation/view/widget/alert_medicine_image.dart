import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class AlertMedicineImage extends StatelessWidget {
  final String? imageUrl;

  const AlertMedicineImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: 70.r,
        height: 70.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.surfaceAltDark,
        ),
        child: Icon(
          Icons.medication_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 32.r,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        imageUrl!,
        width: 70.r,
        height: 70.r,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 70.r,
            height: 70.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.surfaceAltDark,
            ),
            child: Icon(
              Icons.medication_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 32.r,
            ),
          );
        },
      ),
    );
  }
}
