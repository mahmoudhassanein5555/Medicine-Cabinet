// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medicine_cabinet/core/di/service_locator.dart';
// import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
// import 'package:medicine_cabinet/feature/medicine_details/peresentation/view/widgets/medicine_info_card.dart';
// import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
// import 'package:medicine_cabinet/feature/medicine_details/peresentation/view_model/medicine_details_state.dart';
// import 'package:medicine_cabinet/generated/l10n.dart';

// class MedicineDetailsScreen extends StatelessWidget {
//   final String householdId;
//   final String medicineId;

//   const MedicineDetailsScreen({
//     super.key,
//     required this.householdId,
//     required this.medicineId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       lazy: false,
//       create: (_) => getIt<MedicineDetailsCubit>()
//         ..getMedicineDetails(householdId: householdId, medicineId: medicineId),
//       child: const _MedicineDetailsView(),
//     );
//   }
// }

// class _MedicineDetailsView extends StatelessWidget {
//   const _MedicineDetailsView();

//   @override
//   Widget build(BuildContext context) {
//     final l10n = S.of(context);

//     return BlocConsumer<MedicineDetailsCubit, MedicineDetailsState>(
//       listener: (context, state) {
//         if (state.status == MedicineDetailsStatus.error) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errorMessage ?? 'Something went wrong'),
//             ),
//           );
//         }

//         if (state.status == MedicineDetailsStatus.deleteSuccess) {
//           Navigator.of(context).pop();
//         }
//       },
//       builder: (context, state) {
//         if (state.status == MedicineDetailsStatus.initial ||
//             state.status == MedicineDetailsStatus.loading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state.status == MedicineDetailsStatus.error &&
//             state.medicine == null) {
//           return Scaffold(
//             appBar: AppBar(title: Text(l10n.medicinesTitle)),
//             body: Center(
//               child: Text(state.errorMessage ?? 'Something went wrong'),
//             ),
//           );
//         }

//         final medicine = state.medicine;

//         if (medicine == null) {
//           return Scaffold(
//             appBar: AppBar(title: Text(l10n.medicinesTitle)),
//             body: const Center(child: Text('Medicine not found')),
//           );
//         }

//         return _MedicineDetailsBody(medicine: medicine);
//       },
//     );
//   }
// }

// class _MedicineDetailsBody extends StatelessWidget {
//   final MedicineDetailsEntity medicine;

//   const _MedicineDetailsBody({required this.medicine});

//   @override
//   Widget build(BuildContext context) {
//     final l10n = S.of(context);
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(medicine.name),
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _showDeleteDialog(context);
//             },
//             icon: Icon(Icons.delete_outline, color: colorScheme.error),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _MedicineImage(imageUrl: medicine.imageUrl),

//               const SizedBox(height: 24),

//               Text(medicine.name, style: theme.textTheme.headlineMedium),

//               const SizedBox(height: 8),

//               Text(medicine.type, style: theme.textTheme.bodyMedium),

//               const SizedBox(height: 20),

//               MedicineDetailsInfoCard(
//                 icon: Icons.inventory_2_outlined,
//                 label: l10n.commonQuantity,
//                 value: '${medicine.quantity}',
//               ),

//               const SizedBox(height: 12),

//               MedicineDetailsInfoCard(
//                 icon: Icons.category_outlined,
//                 label: 'Category',
//                 value: medicine.category ?? '-',
//               ),

//               const SizedBox(height: 12),

//               MedicineDetailsInfoCard(
//                 icon: Icons.location_on_outlined,
//                 label: l10n.commonStorageLocation,
//                 value: medicine.storageLocation ?? '-',
//               ),

//               const SizedBox(height: 12),

//               MedicineDetailsInfoCard(
//                 icon: Icons.calendar_today_outlined,
//                 label: l10n.commonExpiryDate,
//                 value: _formatDate(medicine.expiryDate),
//               ),

//               const SizedBox(height: 12),

//               MedicineDetailsInfoCard(
//                 icon: Icons.person_outline,
//                 label: l10n.commonOwner,
//                 value: medicine.ownerId,
//               ),

//               const SizedBox(height: 28),

//               _ActionButtons(medicine: medicine),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}/'
//         '${date.month.toString().padLeft(2, '0')}/'
//         '${date.year}';
//   }

//   void _showDeleteDialog(BuildContext context) {
//     final l10n = S.of(context);

//     showDialog<void>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text(l10n.commonDelete),
//           content: Text(l10n.medicineDetailsDeleteDesc),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(dialogContext).pop(),
//               child: Text(l10n.commonCancel),
//             ),
//             FilledButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();

//                 context.read<MedicineDetailsCubit>().deleteMedicine();
//               },
//               child: Text(l10n.commonDelete),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _MedicineImage extends StatelessWidget {
//   final String imageUrl;

//   const _MedicineImage({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Container(
//       width: double.infinity,
//       height: 240,
//       decoration: BoxDecoration(
//         color: colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: imageUrl.isEmpty
//           ? Icon(
//               Icons.medication_outlined,
//               size: 80,
//               color: colorScheme.primary,
//             )
//           : Image.network(
//               imageUrl,
//               fit: BoxFit.contain,
//               errorBuilder: (_, __, ___) {
//                 return Icon(
//                   Icons.medication_outlined,
//                   size: 80,
//                   color: colorScheme.primary,
//                 );
//               },
//               loadingBuilder: (context, child, progress) {
//                 if (progress == null) return child;

//                 return Center(
//                   child: CircularProgressIndicator(
//                     value: progress.expectedTotalBytes != null
//                         ? progress.cumulativeBytesLoaded /
//                               progress.expectedTotalBytes!
//                         : null,
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class _ActionButtons extends StatelessWidget {
//   final MedicineDetailsEntity medicine;

//   const _ActionButtons({required this.medicine});

//   @override
//   Widget build(BuildContext context) {
//     final l10n = S.of(context);
//     final cubit = context.read<MedicineDetailsCubit>();
//     final theme = Theme.of(context);

//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               _showQuantityDialog(context, cubit, medicine.quantity);
//             },
//             icon: const Icon(Icons.add_circle_outline),
//             label: Text(l10n.commonUpdateQuantity),
//           ),
//         ),

//         const SizedBox(height: 12),

//         SizedBox(
//           width: double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: () {
//               _showEditDetailsDialog(context, cubit, medicine);
//             },
//             icon: const Icon(Icons.edit_outlined),
//             label: Text(l10n.commonEditDetails),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: theme.colorScheme.primary,
//               minimumSize: const Size(double.infinity, 48),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         SizedBox(
//           width: double.infinity,
//           child: TextButton.icon(
//             onPressed: () {
//               cubit.deleteMedicine();
//             },
//             icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
//             label: Text(
//               l10n.commonDelete,
//               style: TextStyle(color: theme.colorScheme.error),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showQuantityDialog(
//     BuildContext context,
//     MedicineDetailsCubit cubit,
//     int currentQuantity,
//   ) {
//     final controller = TextEditingController(text: currentQuantity.toString());

//     showDialog<void>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text(S.of(context).commonUpdateQuantity),
//           content: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: S.of(context).commonQuantity,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dialogContext),
//               child: Text(S.of(context).commonCancel),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final quantity = int.tryParse(controller.text);

//                 if (quantity == null || quantity < 0) {
//                   return;
//                 }

//                 cubit.updateQuantity(quantity: quantity);

//                 Navigator.pop(dialogContext);
//               },
//               child: Text(S.of(context).commonApply),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditDetailsDialog(
//     BuildContext context,
//     MedicineDetailsCubit cubit,
//     MedicineDetailsEntity medicine,
//   ) {
//     final nameController = TextEditingController(text: medicine.name);
//     final typeController = TextEditingController(text: medicine.type);
//     final categoryController = TextEditingController(
//       text: medicine.category ?? '',
//     );
//     final locationController = TextEditingController(
//       text: medicine.storageLocation ?? '',
//     );

//     DateTime expiryDate = medicine.expiryDate;

//     showDialog<void>(
//       context: context,
//       builder: (dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(S.of(context).commonEditDetails),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
//                       controller: nameController,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: typeController,
//                       decoration: const InputDecoration(labelText: 'Type'),
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: categoryController,
//                       decoration: const InputDecoration(labelText: 'Category'),
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: locationController,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).commonStorageLocation,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: Text(S.of(context).commonExpiryDate),
//                       subtitle: Text(_formatDate(expiryDate)),
//                       trailing: const Icon(Icons.calendar_today_outlined),
//                       onTap: () async {
//                         final selectedDate = await showDatePicker(
//                           context: context,
//                           initialDate: expiryDate,
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2100),
//                         );

//                         if (selectedDate != null) {
//                           setState(() {
//                             expiryDate = selectedDate;
//                           });
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(dialogContext),
//                   child: Text(S.of(context).commonCancel),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     cubit.editDetails(
//                       name: nameController.text.trim(),
//                       type: typeController.text.trim(),
//                       category: categoryController.text.trim(),
//                       expiryDate: expiryDate,
//                       storageLocation: locationController.text.trim(),
//                     );

//                     Navigator.pop(dialogContext);
//                   },
//                   child: Text(S.of(context).commonApply),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}/'
//         '${date.month.toString().padLeft(2, '0')}/'
//         '${date.year}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
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
      child: const _MedicineDetailsView(),
    );
  }
}

class _MedicineDetailsView extends StatelessWidget {
  const _MedicineDetailsView();

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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == MedicineDetailsStatus.error &&
            state.medicine == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.medicinesTitle)),
            body: Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }

        final medicine = state.medicine;

        if (medicine == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.medicinesTitle)),
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
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    l10n.medicinesTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 22),
                    onPressed: () =>
                        _showEditDetailsDialog(context, cubit, medicine),
                  ),
                ],
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
                            value: '${medicine.quantity} ${medicine.type}',
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
                            value: medicine.ownerId,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MedicineInfoCard(
                            icon: Icons.access_time_rounded,
                            label: 'DATE ADDED',
                            value: 'Jun 3, 2026',
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
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: typeController,
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
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
