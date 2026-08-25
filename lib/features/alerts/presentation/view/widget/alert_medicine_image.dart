import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class AlertMedicineImage extends StatelessWidget {
  final String? imageUrl;

  const AlertMedicineImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark
        ? AppColors.primaryDark.withValues(alpha: 0.12)
        : AppColors.primaryContainerLight;
    final iconColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Container(
        width: 50.r,
        height: 50.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: bgColor,
          border: Border.all(
            color: isDark
                ? AppColors.primaryDark.withValues(alpha: 0.2)
                : AppColors.primaryLight.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.medication_rounded,
          color: iconColor,
          size: 24.r,
        ),
      );
    }

    return Container(
      width: 50.r,
      height: 50.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: bgColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: 50.r,
          height: 50.r,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 16.r,
              height: 16.r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: iconColor,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(
              Icons.medication_rounded,
              color: iconColor,
              size: 24.r,
            ),
          ),
        ),
      ),
    );
  }
}
