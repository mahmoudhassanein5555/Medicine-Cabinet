import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class DeleteMedicineDialog extends StatelessWidget {
  final MedicineDetailsCubit cubit;

  const DeleteMedicineDialog({super.key, required this.cubit});

  static Future<void> show(BuildContext context, {required MedicineDetailsCubit cubit}) {
    return showDialog<void>(
      context: context,
      builder: (_) => DeleteMedicineDialog(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        l10n.commonDelete,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      content: Text(
        l10n.medicineDetailsDeleteDesc,
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.commonCancel,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            cubit.deleteMedicine();
          },
          child: Text(
            l10n.commonDelete,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
