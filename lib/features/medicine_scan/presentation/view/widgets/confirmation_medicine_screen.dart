import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/dialogs/app_toasts.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/confirmation_action_buttons.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/medicine_info_form_card.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/medicine_photo_card.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/member_selector_section.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/quantity_selector_card.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_cubit.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_states.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class ConfirmMedicineScreen extends StatelessWidget {
  const ConfirmMedicineScreen({super.key});

  Future<void> _pickExpiryDate(BuildContext context, MedicineScanCubit cubit) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: cubit.selectedExpiryDate ?? now.add(const Duration(days: 180)),
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.primaryDark,
                    onPrimary: AppColors.backgroundDark,
                    surface: AppColors.surfaceDark,
                    onSurface: AppColors.textPrimaryDark,
                  )
                : const ColorScheme.light(
                    primary: AppColors.primaryLight,
                    onPrimary: Colors.white,
                    surface: AppColors.surfaceLight,
                    onSurface: AppColors.textPrimaryLight,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      cubit.updateExpiryDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;
    final cubit = context.read<MedicineScanCubit>();

    return BlocConsumer<MedicineScanCubit, MedicineScanStates>(
      listener: (context, state) {
        if (state is AddMedicineSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 20.r,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      S.of(context).scanMedicineAddedSuccess,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.successLight,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
          Navigator.of(context).pop();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        } else if (state is AddMedicineErrorState) {
          AppToast.showToast(
            context: context,
            title: S.of(context).commonError,
            description: state.failure.getMessage(context),
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddMedicineLoadingState;

        return Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          appBar: AppBar(
            backgroundColor: isDark
                ? AppColors.surfaceDark
                : AppColors.surfaceLight,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.r,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              S.of(context).scanConfirmMedicineTitle,
              style: TextStyle(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Container(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                height: 1.h,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceAltDark
                            : AppColors.primaryContainerLight.withValues(
                                alpha: 0.5,
                              ),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: isDark
                              ? AppColors.borderDark
                              : primaryColor.withValues(alpha: 0.2),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 20.r,
                            color: primaryColor,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              S.of(context).scanReviewConfirmNotice,
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textPrimaryLight,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    MedicinePhotoCard(
                      imageUrl: cubit.scannedImageUrl,
                      onChangePhoto: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 18.h),

                    MedicineInfoFormCard(
                      nameController: cubit.nameController,
                      categoryController: cubit.categoryController,
                      typeController: cubit.typeController,
                      strengthController: cubit.strengthController,
                      storageLocationController: cubit.storageLocationController,
                      descriptionController: cubit.descriptionController,
                      expiryDateController: cubit.expiryDateController,
                      onSelectExpiryDate: () => _pickExpiryDate(context, cubit),
                    ),
                    SizedBox(height: 20.h),

                    MemberSelectorSection(
                      members: cubit.householdMembers,
                      selectedMember: cubit.selectedMember,
                      isLoading: cubit.isLoadingMembers,
                      errorMessage: cubit.getMembersErrorMessage(context),
                      onMemberSelected: cubit.selectMember,
                      onAddMemberTap: () {},
                    ),
                    SizedBox(height: 20.h),

                    QuantitySelectorCard(
                      quantity: cubit.quantity,
                      unit: cubit.typeController.text.trim(),
                      onIncrement: cubit.incrementQuantity,
                      onDecrement: cubit.decrementQuantity,
                    ),
                    SizedBox(height: 28.h),

                    ConfirmationActionButtons(
                      isLoading: isLoading,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: cubit.saveMedicine,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
