import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class EditMedicineDetailsDialog extends StatefulWidget {
  final MedicineDetailsEntity medicine;
  final MedicineDetailsCubit cubit;

  const EditMedicineDetailsDialog({
    super.key,
    required this.medicine,
    required this.cubit,
  });

  static Future<void> show(
    BuildContext context, {
    required MedicineDetailsEntity medicine,
    required MedicineDetailsCubit cubit,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => EditMedicineDetailsDialog(
        medicine: medicine,
        cubit: cubit,
      ),
    );
  }

  @override
  State<EditMedicineDetailsDialog> createState() =>
      _EditMedicineDetailsDialogState();
}

class _EditMedicineDetailsDialogState extends State<EditMedicineDetailsDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _typeController;
  late final TextEditingController _categoryController;
  late final TextEditingController _locationController;
  late final TextEditingController _descriptionController;
  late DateTime _expiryDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine.name);
    _typeController = TextEditingController(text: widget.medicine.type);
    _categoryController =
        TextEditingController(text: widget.medicine.category ?? '');
    _locationController =
        TextEditingController(text: widget.medicine.storageLocation ?? '');
    _descriptionController =
        TextEditingController(text: widget.medicine.description ?? '');
    _expiryDate = widget.medicine.expiryDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
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
        l10n.commonEditDetails,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                labelText: l10n.medicineDetailsName,
                labelStyle: TextStyle(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _typeController,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                labelText: l10n.medicineDetailsType,
                labelStyle: TextStyle(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _categoryController,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                labelText: l10n.medicineDetailsCategory,
                labelStyle: TextStyle(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _locationController,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                labelText: l10n.commonStorageLocation,
                labelStyle: TextStyle(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                labelText: l10n.medicineDetailsDescription,
                labelStyle: TextStyle(fontSize: 13.sp),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.commonExpiryDate,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${_expiryDate.day.toString().padLeft(2, '0')}/'
                '${_expiryDate.month.toString().padLeft(2, '0')}/'
                '${_expiryDate.year}',
                style: TextStyle(fontSize: 13.sp),
              ),
              trailing: Icon(Icons.calendar_today_outlined, size: 20.r),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _expiryDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  setState(() {
                    _expiryDate = selectedDate;
                  });
                }
              },
            ),
          ],
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
            widget.cubit.editDetails(
              name: _nameController.text.trim(),
              type: _typeController.text.trim(),
              category: _categoryController.text.trim(),
              expiryDate: _expiryDate,
              storageLocation: _locationController.text.trim(),
              description: _descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim(),
            );
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
