import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineInfoFormCard extends StatelessWidget {
  const MedicineInfoFormCard({
    super.key,
    required this.nameController,
    required this.categoryController,
    required this.typeController,
    required this.strengthController,
    required this.storageLocationController,
    required this.descriptionController,
    required this.expiryDateController,
    this.onSelectExpiryDate,
  });

  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController typeController;
  final TextEditingController strengthController;
  final TextEditingController storageLocationController;
  final TextEditingController descriptionController;
  final TextEditingController expiryDateController;
  final VoidCallback? onSelectExpiryDate;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final secondaryColor = isDark ? AppColors.secondaryDark : AppColors.secondaryLight;

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
      padding: EdgeInsets.all(18.r),
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
                  Icons.medication_liquid_rounded,
                  size: 18.r,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                S.of(context).scanMedicineDetailsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          _buildFieldLabel(
            label: S.of(context).scanMedicineNameLabel,
            isRequired: true,
            isDark: isDark,
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: nameController,
            hintText: S.of(context).scanMedicineNameHint,
            prefixIcon: Icon(
              Icons.medication_rounded,
              color: secondaryColor,
              size: 20.r,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).scanMedicineNameValidation;
              }
              return null;
            },
          ),
          SizedBox(height: 14.h),
          _buildFieldLabel(
            label: S.of(context).scanCategoryLabel,
            isRequired: true,
            isDark: isDark,
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: categoryController,
            hintText: S.of(context).scanCategoryHint,
            prefixIcon: Icon(
              Icons.science_rounded,
              color: secondaryColor,
              size: 20.r,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).scanCategoryValidation;
              }
              return null;
            },
          ),
          SizedBox(height: 14.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel(
                label: S.of(context).scanFormTypeLabel,
                isRequired: true,
                isDark: isDark,
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: typeController,
                hintText: S.of(context).scanFormTypeHint,
                prefixIcon: Icon(
                  Icons.category_rounded,
                  color: secondaryColor,
                  size: 20.r,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).scanFieldRequired;
                  }
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _buildFieldLabel(
            label: S.of(context).commonExpiryDate,
            isRequired: true,
            isDark: isDark,
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: expiryDateController,
            readOnly: true,
            onTap: onSelectExpiryDate,
            hintText: S.of(context).scanExpiryDateHint,
            prefixIcon: Icon(
              Icons.calendar_month_rounded,
              color: secondaryColor,
              size: 20.r,
            ),
            suffixWidget: Icon(
              Icons.arrow_drop_down_rounded,
              color: secondaryColor,
              size: 24.r,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).scanExpiryDateValidation;
              }
              return null;
            },
          ),
          SizedBox(height: 14.h),
          _buildFieldLabel(
            label: S.of(context).commonStorageLocation,
            isRequired: true,
            isDark: isDark,
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: storageLocationController,
            hintText: S.of(context).scanStorageLocationHint,
            prefixIcon: Icon(
              Icons.inventory_2_rounded,
              color: secondaryColor,
              size: 20.r,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).scanStorageLocationValidation;
              }
              return null;
            },
          ),
          SizedBox(height: 14.h),
          _buildFieldLabel(
            label: S.of(context).scanNotesLabel,
            isRequired: false,
            isDark: isDark,
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: descriptionController,
            hintText: S.of(context).scanNotesHint,
            maxLines: 3,
            minLines: 2,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 28.h),
              child: Icon(
                Icons.note_alt_rounded,
                color: secondaryColor,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel({
    required String label,
    required bool isRequired,
    required bool isDark,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        if (isRequired) ...[
          SizedBox(width: 4.w),
          Text(
            '*',
            style: TextStyle(
              color: isDark ? AppColors.errorDark : AppColors.errorLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

