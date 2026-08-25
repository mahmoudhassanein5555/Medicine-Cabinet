import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/date_formatter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class SearchInitialView extends StatelessWidget {
  const SearchInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180.r,
            height: 180.r,
            child: Lottie.asset(AppAssets.search, fit: BoxFit.contain),
          ),
          SizedBox(height: 20.h),
          Text(
            l10n.searchStartTyping,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchErrorStateView extends StatelessWidget {
  final String errorMessage;

  const SearchErrorStateView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180.r,
            height: 180.r,
            child: Lottie.asset(AppAssets.noSearch, fit: BoxFit.contain),
          ),
          SizedBox(height: 20.h),
          Text(
            errorMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchEmptyView extends StatelessWidget {
  const SearchEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180.r,
            height: 180.r,
            child: Lottie.asset(AppAssets.noSearch, fit: BoxFit.contain),
          ),
          SizedBox(height: 20.h),
          Text(
            l10n.searchNoResults,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchResultsList extends StatelessWidget {
  final List<MedicineEntity> medicines;

  const SearchResultsList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: medicines.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        final isExpired = medicine.expiryDate.isBefore(DateTime.now());

        return MedicineCard(
          imageUrl: medicine.imageUrl,
          name: medicine.name,
          type: medicine.type,
          remaining: medicine.quantity,
          expiry: formatExpiryDate(context, medicine.expiryDate),
          addedBy: medicine.addedBy,
          status: isExpired
              ? S.of(context).commonExpired
              : S.of(context).commonHealthy,
        );
      },
    );
  }
}
