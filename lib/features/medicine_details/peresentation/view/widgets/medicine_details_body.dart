import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/core/utils/medicine_details_localization.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_description_section.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_details_header.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_expiry_banner.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_hero_section.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_info_card.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/quick_actions_section.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineDetailsBody extends StatelessWidget {
  final MedicineDetailsEntity medicine;

  const MedicineDetailsBody({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final cubit = context.read<MedicineDetailsCubit>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: MedicineDetailsHeader(
                title: l10n.medicinesTitle,
                onBack: () => Navigator.of(context).pop(),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                child: Column(
                  children: [
                    // Medicine image + name
                    MedicineHeroSection(medicine: medicine),

                    SizedBox(height: 20.h),

                    // Expiry status
                    MedicineExpiryBanner(medicine: medicine),

                    SizedBox(height: 16.h),

                    // Description (if present)
                    if (medicine.description != null &&
                        medicine.description!.trim().isNotEmpty) ...[
                      MedicineDescriptionSection(
                        description: medicine.description,
                      ),
                      SizedBox(height: 12.h),
                    ],

                    // Quantity + expiry date
                    Row(
                      children: [
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.all_inclusive_rounded,
                            label: l10n.commonQuantity,
                            value:
                                '${medicine.quantity} ${getLocalizedMedicineType(context, medicine.type)}',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.calendar_today_outlined,
                            label: l10n.commonExpiryDate,
                            value: DateFormat.yMMMM(
                              Localizations.localeOf(context).toString(),
                            ).format(medicine.expiryDate),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Owner + date added
                    Row(
                      children: [
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.person_outline_rounded,
                            label: l10n.commonOwner,
                            value: medicine.ownerName ?? '-',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.access_time_rounded,
                            label: l10n.commonDateAdded,
                            value: DateFormat.yMMMM(
                              Localizations.localeOf(context).toString(),
                            ).format(medicine.createdAt),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Storage location
                    MedicineInfoCard(
                      icon: Icons.location_on_outlined,
                      label: l10n.commonStorageLocation,
                      value: medicine.storageLocation ?? '-',
                      isFullWidth: true,
                    ),

                    SizedBox(height: 24.h),

                    // Quick actions
                    QuickActionsSection(
                      medicine: medicine,
                      cubit: cubit,
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
