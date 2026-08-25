import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class UpdateQuantityDialog extends StatefulWidget {
  final int currentQuantity;
  final MedicineDetailsCubit cubit;

  const UpdateQuantityDialog({
    super.key,
    required this.currentQuantity,
    required this.cubit,
  });

  static Future<void> show(
    BuildContext context, {
    required int currentQuantity,
    required MedicineDetailsCubit cubit,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => UpdateQuantityDialog(
        currentQuantity: currentQuantity,
        cubit: cubit,
      ),
    );
  }

  @override
  State<UpdateQuantityDialog> createState() => _UpdateQuantityDialogState();
}

class _UpdateQuantityDialogState extends State<UpdateQuantityDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentQuantity.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        l10n.commonUpdateQuantity,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 16.sp),
        decoration: InputDecoration(
          labelText: l10n.commonQuantity,
          labelStyle: TextStyle(fontSize: 14.sp),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.commonCancel,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(_controller.text);
            if (quantity == null || quantity < 0) return;

            widget.cubit.updateQuantity(quantity: quantity);
            Navigator.pop(context);
          },
          child: Text(
            l10n.commonApply,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
