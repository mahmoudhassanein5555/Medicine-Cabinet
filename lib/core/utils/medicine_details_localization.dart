import 'package:flutter/widgets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

String getLocalizedMedicineType(BuildContext context, String type) {
  final l10n = S.of(context);

  switch (type.trim().toLowerCase()) {
    case 'tablets':
      return l10n.medicineTypeTablets;

    case 'enteric coated tablets':
      return l10n.medicineTypeEntericCoatedTablets;

    case 'liquid':
      return l10n.medicineTypeLiquid;

    case 'syrup':
      return l10n.medicineTypeSyrup;

    case 'solution for im injection / oral use':
      return l10n.medicineTypeSolutionForImOralUse;

    case 'capsules':
      return l10n.medicineTypeCapsules;

    default:
      return type;
  }
}

String getLocalizedMedicineCategory(BuildContext context, String category) {
  final l10n = S.of(context);

  switch (category.trim().toLowerCase()) {
    case 'pain relief':
      return l10n.medicineCategoryPainRelief;

    case 'cold & flu':
      return l10n.medicineCategoryColdFlu;

    case 'allergy':
      return l10n.medicineCategoryAllergy;

    case 'digestive':
      return l10n.medicineCategoryDigestive;

    case 'vitamins':
      return l10n.medicineCategoryVitamins;

    case 'antibiotics':
      return l10n.medicineCategoryAntibiotics;

    case 'skin care':
      return l10n.medicineCategorySkinCare;

    default:
      return category;
  }
}
