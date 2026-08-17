import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/utils/medicine_localization.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_details_header.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_expiry_banner.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_hero_section.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_info_card.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/quick_actions_section.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_state.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      child: const _MedicineDetailsView(),
    );
  }
}

class _MedicineDetailsView extends StatelessWidget {
  const _MedicineDetailsView();
  MedicineDetailsEntity _dummyMedicine() {
    final now = DateTime.now();

    return MedicineDetailsEntity(
      id: 'loading',
      name: 'Panadol',
      type: 'Pills',
      quantity: 20,
      expiryDate: now.add(const Duration(days: 30)),
      imageUrl: '',
      ownerId: 'Owner',
      addedBy: 'User',
      createdAt: now,
      updatedAt: now,
      storageLocation: 'Kitchen cabinet',
      category: 'Pain relief',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocConsumer<MedicineDetailsCubit, MedicineDetailsState>(
      listener: (context, state) {
        if (state.status == MedicineDetailsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }

        if (state.status == MedicineDetailsStatus.deleteSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.status == MedicineDetailsStatus.initial ||
            state.status == MedicineDetailsStatus.loading) {
          return Skeletonizer(
            enabled: true,
            child: _MedicineDetailsBody(medicine: _dummyMedicine()),
          );
        }

        if (state.status == MedicineDetailsStatus.error &&
            state.medicine == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.medicinesTitle),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }

        final medicine = state.medicine;

        if (medicine == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.medicinesTitle),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            body: const Center(child: Text('Medicine not found')),
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

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    MedicineHeroSection(medicine: medicine),
                    const SizedBox(height: 20),
                    MedicineExpiryBanner(medicine: medicine),
                    const SizedBox(height: 16),
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
                    Row(
                      children: [
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.person_outline_rounded,
                            label: l10n.commonOwner,
                            value: medicine.ownerName ?? ".....",
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
                    MedicineInfoCard(
                      icon: Icons.location_on_outlined,
                      label: l10n.commonStorageLocation,
                      value: medicine.storageLocation ?? '-',
                      isFullWidth: true,
                    ),
                    const SizedBox(height: 24),
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
            return AlertDialog(
              title: Text(S.of(context).commonEditDetails),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: S.of(context).medicineDetailsName,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                        labelText: S.of(context).medicineDetailsType,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: S.of(context).medicineDetailsCategory,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: S.of(context).commonStorageLocation,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(S.of(context).commonExpiryDate),
                      subtitle: Text(
                        '${expiryDate.day.toString().padLeft(2, '0')}/${expiryDate.month.toString().padLeft(2, '0')}/${expiryDate.year}',
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
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(S.of(context).commonCancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    cubit.editDetails(
                      name: nameController.text.trim(),
                      type: typeController.text.trim(),
                      category: categoryController.text.trim(),
                      expiryDate: expiryDate,
                      storageLocation: locationController.text.trim(),
                    );

                    Navigator.pop(dialogContext);
                  },
                  child: Text(S.of(context).commonApply),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
