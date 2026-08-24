import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/custom_text_field.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_description_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/utils/medicine_details_localization.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_details_error.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_details_header.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_expiry_banner.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_hero_section.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_info_card.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/quick_actions_section.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_state.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final String householdId;
  final String medicineId;

  const MedicineDetailsScreen({
    super.key,
    required this.householdId,
    required this.medicineId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => getIt<MedicineDetailsCubit>()
        ..getMedicineDetails(householdId: householdId, medicineId: medicineId),
      child: _MedicineDetailsView(
        householdId: householdId,
        medicineId: medicineId,
      ),
    );
  }
}

class _MedicineDetailsView extends StatelessWidget {
  final String householdId;
  final String medicineId;

  const _MedicineDetailsView({
    required this.householdId,
    required this.medicineId,
  });

  MedicineDetailsEntity _dummyMedicine() {
    final now = DateTime.now();

    return MedicineDetailsEntity(
      id: AppStrings.dummyMedicineId,
      name: AppStrings.dummyMedicineName,
      type: AppStrings.dummyMedicineType,
      quantity: AppStrings.dummyMedicineQuantity,
      expiryDate: now.add(const Duration(days: 30)),
      imageUrl: AppStrings.dummyMedicineImageUrl,
      ownerId: AppStrings.dummyMedicineOwnerId,
      addedBy: AppStrings.dummyMedicineAddedBy,
      createdAt: now,
      updatedAt: now,
      storageLocation: AppStrings.dummyMedicineStorageLocation,
      category: AppStrings.dummyMedicineCategory,
      description: AppStrings.dummyMedicineDescription,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicineDetailsCubit, MedicineDetailsState>(
      listener: (context, state) {
        if (state.status == MedicineDetailsStatus.deleteSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final cubit = context.read<MedicineDetailsCubit>();

        if (state.status == MedicineDetailsStatus.initial ||
            state.status == MedicineDetailsStatus.loading) {
          return Skeletonizer(
            enabled: true,
            child: _MedicineDetailsBody(medicine: _dummyMedicine()),
          );
        }

        if (state.status == MedicineDetailsStatus.error &&
            state.medicine == null) {
          return MedicineDetailsError(
            message: state.errorMessage,
            onRetry: () {
              cubit.getMedicineDetails(
                householdId: householdId,
                medicineId: medicineId,
              );
            },
          );
        }

        final medicine = state.medicine;

        if (medicine == null) {
          return MedicineDetailsError(
            message: S.of(context).medicineDetailsNotFound,
            onRetry: () {
              cubit.getMedicineDetails(
                householdId: householdId,
                medicineId: medicineId,
              );
            },
          );
        }

        return _MedicineDetailsBody(medicine: medicine);
      },
    );
  }
}

class _MedicineDetailsBody extends StatelessWidget {
  final MedicineDetailsEntity medicine;

  const _MedicineDetailsBody({required this.medicine});

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MedicineDetailsHeader(
                title: l10n.medicinesTitle,
                onBack: () => Navigator.of(context).pop(),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    // Medicine image + name
                    MedicineHeroSection(medicine: medicine),

                    const SizedBox(height: 20),

                    // Expiry status
                    MedicineExpiryBanner(medicine: medicine),
                    const SizedBox(height: 12),
                    MedicineDescriptionSection(
                      description: medicine.description,
                    ),

                    const SizedBox(height: 16),

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
                        const SizedBox(width: 12),
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

                    const SizedBox(height: 12),

                    // Owner + date added
                    Row(
                      children: [
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.person_outline_rounded,
                            label: l10n.commonOwner,
                            value: medicine.addedBy.isNotEmpty
                                ? medicine.addedBy
                                : 'no name',
                          ),
                        ),
                        const SizedBox(width: 12),
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

                    const SizedBox(height: 12),

                    // Storage location
                    MedicineInfoCard(
                      icon: Icons.location_on_outlined,
                      label: l10n.commonStorageLocation,
                      value: medicine.storageLocation ?? '-',
                      isFullWidth: true,
                    ),

                    const SizedBox(height: 24),

                    // Quick actions
                    QuickActionsSection(
                      medicine: medicine,
                      cubit: cubit,
                      onEditPressed: () =>
                          _showEditDetailsDialog(context, cubit, medicine),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDetailsDialog(
    BuildContext context,
    MedicineDetailsCubit cubit,
    MedicineDetailsEntity medicine,
  ) {
    final nameController = TextEditingController(text: medicine.name);

    final typeController = TextEditingController(text: medicine.type);
    final descriptionController = TextEditingController(
      text: medicine.description ?? '',
    );

    final categoryController = TextEditingController(
      text: medicine.category ?? '',
    );

    final locationController = TextEditingController(
      text: medicine.storageLocation ?? '',
    );

    DateTime expiryDate = medicine.expiryDate;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final l10n = S.of(context);

            return AlertDialog(
              title: Text(l10n.commonEditDetails),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: nameController,
                      labelText: l10n.medicineDetailsName,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: typeController,
                      labelText: l10n.medicineDetailsType,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: categoryController,
                      labelText: l10n.medicineDetailsCategory,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: descriptionController,
                      labelText: l10n.medicineDetailsDescription,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: locationController,
                      labelText: l10n.commonStorageLocation,
                    ),
                    const SizedBox(height: 16),
                    // Expiry date
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.commonExpiryDate),
                      subtitle: Text(
                        '${expiryDate.day.toString().padLeft(2, '0')}/'
                        '${expiryDate.month.toString().padLeft(2, '0')}/'
                        '${expiryDate.year}',
                      ),
                      trailing: const Icon(Icons.calendar_today_outlined),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: expiryDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            expiryDate = selectedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(l10n.commonCancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    cubit.editDetails(
                      name: nameController.text.trim(),
                      type: typeController.text.trim(),
                      category: categoryController.text.trim(),
                      expiryDate: expiryDate,
                      storageLocation: locationController.text.trim(),
                      description: descriptionController.text.trim(),
                    );

                    Navigator.pop(dialogContext);
                  },
                  child: Text(l10n.commonApply),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
