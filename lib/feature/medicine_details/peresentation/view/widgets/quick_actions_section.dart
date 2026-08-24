import 'package:flutter/material.dart';

import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/action_button.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class QuickActionsSection extends StatelessWidget {
  final MedicineDetailsEntity medicine;
  final MedicineDetailsCubit cubit;
  final VoidCallback onEditPressed;

  const QuickActionsSection({
    super.key,
    required this.medicine,
    required this.cubit,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final errorColor = isDark ? AppColors.errorDark : AppColors.errorLight;

    final errorBackground = isDark
        ? AppColors.errorDark.withValues(alpha: 0.12)
        : AppColors.errorContainerLight;

    return Column(
      children: [
        /// Update Quantity + Edit Details
        Row(
          children: [
            Expanded(
              child: ActionButton(
                icon: Icons.add_rounded,
                label: l10n.commonUpdateQuantity,
                onPressed: () =>
                    _showQuantityDialog(context, medicine.quantity),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionButton(
                icon: Icons.edit_outlined,
                label: l10n.commonEditDetails,
                onPressed: onEditPressed,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Delete - Full Width
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            icon: Icons.delete_outline_rounded,
            label: l10n.commonDelete,
            color: errorColor,
            backgroundColor: errorBackground,
            onPressed: () => _showDeleteDialog(context),
          ),
        ),
      ],
    );
  }

  void _showQuantityDialog(BuildContext context, int currentQuantity) {
    final controller = TextEditingController(text: currentQuantity.toString());

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(S.of(context).commonUpdateQuantity),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: S.of(context).commonQuantity,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(S.of(context).commonCancel),
            ),
            ElevatedButton(
              onPressed: () {
                final quantity = int.tryParse(controller.text);

                if (quantity == null || quantity < 0) {
                  return;
                }

                cubit.updateQuantity(quantity: quantity);

                Navigator.pop(dialogContext);
              },
              child: Text(S.of(context).commonApply),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final l10n = S.of(context);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.commonDelete),
          content: Text(l10n.medicineDetailsDeleteDesc),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                cubit.deleteMedicine();
              },
              child: Text(l10n.commonDelete),
            ),
          ],
        );
      },
    );
  }
}
