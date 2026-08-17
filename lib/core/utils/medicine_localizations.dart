// String filterTitle(BuildContext context, MedicineFilter filter) {
//     final l10n = S.of(context);

//     switch (filter) {
//       case MedicineFilter.all:
//         return l10n.commonAll;

//       case MedicineFilter.expiringSoon:
//         return l10n.commonExpiringSoon;

//       case MedicineFilter.lowStock:
//         return l10n.commonLowStock;

//       case MedicineFilter.expired:
//         return l10n.commonExpired;
//     }
//   }

//   String statusTitle(BuildContext context, MedicineStatus status) {
//     final l10n = S.of(context);

//     switch (status) {
//       case MedicineStatus.healthy:
//         return l10n.commonHealthy;

//       case MedicineStatus.expiring:
//         return l10n.commonExpiringShort;

//       case MedicineStatus.lowStock:
//         return l10n.commonLowStock;

//       case MedicineStatus.expired:
//         return l10n.commonExpired;
//     }
//   }

//   String sortTitle(BuildContext context, MedicineSort sort) {
//     final l10n = S.of(context);

//     switch (sort) {
//       case MedicineSort.expiryDate:
//         return l10n.medicinesSortOptionExpiry;

//       case MedicineSort.name:
//         return l10n.medicinesSortOptionName;

//       case MedicineSort.quantity:
//         return l10n.medicinesSortOptionQuantity;

//       case MedicineSort.recentlyAdded:
//         return l10n.medicinesSortOptionRecentlyAdded;
//     }
//   }
import 'package:flutter/material.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

String getMedicineFilterTitle(BuildContext context, MedicineFilter filter) {
  final l10n = S.of(context);

  switch (filter) {
    case MedicineFilter.all:
      return l10n.commonAll;

    case MedicineFilter.expiringSoon:
      return l10n.commonExpiringSoon;

    case MedicineFilter.lowStock:
      return l10n.commonLowStock;

    case MedicineFilter.expired:
      return l10n.commonExpired;
  }
}

String getMedicineStatusTitle(BuildContext context, MedicineStatus status) {
  final l10n = S.of(context);

  switch (status) {
    case MedicineStatus.healthy:
      return l10n.commonHealthy;

    case MedicineStatus.expiring:
      return l10n.commonExpiringShort;

    case MedicineStatus.lowStock:
      return l10n.commonLowStock;

    case MedicineStatus.expired:
      return l10n.commonExpired;
  }
}

String getMedicineSortTitle(BuildContext context, MedicineSort sort) {
  final l10n = S.of(context);

  switch (sort) {
    case MedicineSort.expiryDate:
      return l10n.medicinesSortOptionExpiry;

    case MedicineSort.name:
      return l10n.medicinesSortOptionName;

    case MedicineSort.quantity:
      return l10n.medicinesSortOptionQuantity;

    case MedicineSort.recentlyAdded:
      return l10n.medicinesSortOptionRecentlyAdded;
  }
}
