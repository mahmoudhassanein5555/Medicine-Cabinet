import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/action_button.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/delete_medicine_dialog.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/edit_medicine_details_dialog.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/update_quantity_dialog.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class QuickActionsSection extends StatelessWidget {
  final MedicineDetailsEntity medicine;
  final MedicineDetailsCubit cubit;

  const QuickActionsSection({
    super.key,
    required this.medicine,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final successColor = isDark
        ? AppColors.successDark
        : AppColors.successLight;

    final successBackground = isDark
        ? AppColors.successDark.withValues(alpha: 0.12)
        : AppColors.successContainerLight;

    final errorColor = isDark ? AppColors.errorDark : AppColors.errorLight;

    final errorBackground = isDark
        ? AppColors.errorDark.withValues(alpha: 0.12)
        : AppColors.errorContainerLight;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ActionButton(
                icon: Icons.add_rounded,
                label: l10n.commonUpdateQuantity,
                onPressed: () => UpdateQuantityDialog.show(
                  context,
                  currentQuantity: medicine.quantity,
                  cubit: cubit,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ActionButton(
                icon: Icons.edit_outlined,
                label: l10n.commonEditDetails,
                onPressed: () => EditMedicineDetailsDialog.show(
                  context,
                  medicine: medicine,
                  cubit: cubit,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        Row(
          children: [
            Expanded(
              child: ActionButton(
                icon: Icons.check_rounded,
                label: l10n.commonMarkAsUsed,
                color: successColor,
                backgroundColor: successBackground,
                onPressed: () {
                  if (medicine.quantity > 0) {
                    cubit.updateQuantity(quantity: medicine.quantity - 1);
                  }
                },
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: ActionButton(
                icon: Icons.delete_outline_rounded,
                label: l10n.commonDelete,
                color: errorColor,
                backgroundColor: errorBackground,
                onPressed: () => DeleteMedicineDialog.show(
                  context,
                  cubit: cubit,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
