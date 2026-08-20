import 'package:flutter/material.dart';
import 'package:medicine_cabinet/features/search/domain/enum/search_medicine_status.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

String getSearchMedicineStatusTitle(
  BuildContext context,
  SearchMedicineStatus status,
) {
  final l10n = S.of(context);

  switch (status) {
    case SearchMedicineStatus.healthy:
      return l10n.commonHealthy;

    case SearchMedicineStatus.expiring:
      return l10n.commonExpiringShort;

    case SearchMedicineStatus.lowStock:
      return l10n.commonLowStock;

    case SearchMedicineStatus.expired:
      return l10n.commonExpired;
  }
}
