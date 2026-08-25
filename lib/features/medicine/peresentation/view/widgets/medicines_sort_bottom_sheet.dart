import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_sort_option.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicinesSortBottomSheet extends StatefulWidget {
  final MedicineSort currentSort;
  final ValueChanged<MedicineSort> onSortSelected;

  const MedicinesSortBottomSheet({
    super.key,
    required this.currentSort,
    required this.onSortSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required MedicineSort currentSort,
    required ValueChanged<MedicineSort> onSortSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MedicinesSortBottomSheet(
        currentSort: currentSort,
        onSortSelected: onSortSelected,
      ),
    );
  }

  @override
  State<MedicinesSortBottomSheet> createState() =>
      _MedicinesSortBottomSheetState();
}

class _MedicinesSortBottomSheetState extends State<MedicinesSortBottomSheet> {
  late MedicineSort temporarySort;

  @override
  void initState() {
    super.initState();
    temporarySort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.outline,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          SizedBox(height: 18.h),

          /// Title
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.medicinesSortBy,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
              ),
            ),
          ),

          SizedBox(height: 14.h),

          MedicineSortOption(
            title: l10n.medicinesSortOptionExpiry,
            value: MedicineSort.expiryDate,
            selectedValue: temporarySort,
            onTap: () {
              setState(() {
                temporarySort = MedicineSort.expiryDate;
              });
            },
          ),

          MedicineSortOption(
            title: l10n.medicinesSortOptionName,
            value: MedicineSort.name,
            selectedValue: temporarySort,
            onTap: () {
              setState(() {
                temporarySort = MedicineSort.name;
              });
            },
          ),

          MedicineSortOption(
            title: l10n.medicinesSortOptionQuantity,
            value: MedicineSort.quantity,
            selectedValue: temporarySort,
            onTap: () {
              setState(() {
                temporarySort = MedicineSort.quantity;
              });
            },
          ),

          MedicineSortOption(
            title: l10n.medicinesSortOptionRecentlyAdded,
            value: MedicineSort.recentlyAdded,
            selectedValue: temporarySort,
            onTap: () {
              setState(() {
                temporarySort = MedicineSort.recentlyAdded;
              });
            },
          ),

          SizedBox(height: 12.h),

          /// Apply
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                widget.onSortSelected(temporarySort);
                Navigator.pop(context);
              },
              child: Text(
                l10n.commonApply,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
