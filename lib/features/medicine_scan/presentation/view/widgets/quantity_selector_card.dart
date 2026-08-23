import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class QuantitySelectorCard extends StatelessWidget {
  const QuantitySelectorCard({
    super.key,
    required this.quantity,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final primaryColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 1.2.w),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDark.withValues(alpha: 0.15)
                      : AppColors.primaryContainerLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.format_list_numbered_rounded,
                  size: 18.r,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  S.of(context).scanHowManyDoYouHave,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStepButton(
                    icon: Icons.remove_rounded,
                    isEnabled: quantity > 1,
                    onTap: onDecrement,
                    isDark: isDark,
                    primaryColor: primaryColor,
                  ),
                  SizedBox(width: 12.w),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 32.w),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            '$quantity',
                            key: ValueKey<int>(quantity),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  _buildStepButton(
                    icon: Icons.add_rounded,
                    isEnabled: true,
                    onTap: onIncrement,
                    isDark: isDark,
                    primaryColor: primaryColor,
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceAltDark
                        : AppColors.surfaceAltLight,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: borderColor, width: 1.w),
                  ),
                  child: Text(
                    unit.isNotEmpty ? unit : S.of(context).scanUnitsDefault,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
    required bool isDark,
    required Color primaryColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: isEnabled
                ? (isDark
                      ? AppColors.surfaceAltDark
                      : AppColors.primaryContainerLight.withValues(alpha: 0.6))
                : (isDark
                      ? AppColors.surfaceAltDark.withValues(alpha: 0.4)
                      : AppColors.surfaceAltLight.withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isEnabled
                  ? (isDark
                        ? AppColors.borderDark
                        : primaryColor.withValues(alpha: 0.2))
                  : Colors.transparent,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20.r,
              color: isEnabled
                  ? primaryColor
                  : (isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight),
            ),
          ),
        ),
      ),
    );
  }
}

