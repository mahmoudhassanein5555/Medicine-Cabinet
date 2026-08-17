// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:medicine_cabinet/core/constants/app_colors.dart';
// import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
// import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
// import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';
// import 'package:medicine_cabinet/generated/l10n.dart';

// class MedicinesScreen extends StatefulWidget {
//   const MedicinesScreen({super.key});

//   @override
//   State<MedicinesScreen> createState() => _MedicinesScreenState();
// }

// class _MedicinesScreenState extends State<MedicinesScreen> {
//   final TextEditingController searchController = TextEditingController();

//   final List<MedicineFilter> filters = [
//     MedicineFilter.all,
//     MedicineFilter.expiringSoon,
//     MedicineFilter.lowStock,
//     MedicineFilter.expired,
//   ];

//   @override
//   void initState() {
//     super.initState();

//     context.read<MedicineCubit>().getMedicines();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   String filterTitle(BuildContext context, MedicineFilter filter) {
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

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<MedicineCubit, MedicineState>(
//           builder: (context, state) {
//             if (state is MedicineLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: theme.colorScheme.primary,
//                 ),
//               );
//             }

//             if (state is MedicineErrorState) {
//               return Center(
//                 child: Text(state.message, style: theme.textTheme.bodyMedium),
//               );
//             }

//             if (state is MedicineSuccessState) {
//               return _buildMedicinesContent(context, state);
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicinesContent(
//     BuildContext context,
//     MedicineSuccessState state,
//   ) {
//     final theme = Theme.of(context);

//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: const EdgeInsets.fromLTRB(33, 28, 33, 0),
//           sliver: SliverToBoxAdapter(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   S.of(context).medicinesTitle,
//                   style: theme.textTheme.headlineMedium?.copyWith(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w800,
//                     letterSpacing: -0.5,
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 /// Search
//                 CustomTextFormField(
//                   controller: searchController,
//                   hintText: S.of(context).medicinesSearchHint,
//                   hintTextColor: theme.brightness == Brightness.dark
//                       ? AppColors.textMutedDark
//                       : AppColors.textMutedLight,
//                   onChanged: (value) {
//                     // Search logic later
//                   },
//                   prefixIcon: Icon(
//                     Icons.search_rounded,
//                     color: theme.brightness == Brightness.dark
//                         ? AppColors.textMutedDark
//                         : AppColors.textMutedLight,
//                     size: 20,
//                   ),
//                   suffixWidget: Icon(
//                     Icons.tune_rounded,
//                     color: theme.brightness == Brightness.dark
//                         ? AppColors.textMutedDark
//                         : AppColors.textMutedLight,
//                     size: 20,
//                   ),
//                   borderRadius: BorderRadius.circular(22),
//                 ),

//                 const SizedBox(height: 14),

//                 /// Filters
//                 SizedBox(
//                   height: 38,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: filters.length,
//                     separatorBuilder: (_, __) {
//                       return const SizedBox(width: 9);
//                     },
//                     itemBuilder: (context, index) {
//                       final filter = filters[index];

//                       return MedicineFilterChip(
//                         title: filterTitle(context, filter),
//                         isSelected: state.selectedFilter == filter,
//                         onTap: () {
//                           context.read<MedicineCubit>().filterMedicines(filter);
//                         },
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 /// Scroll indicator
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.chevron_left_rounded,
//                       size: 20,
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: theme.colorScheme.outline,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right_rounded,
//                       size: 20,
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 /// Items + Sort
//                 Row(
//                   children: [
//                     Text(
//                       S.of(context).medicinesItemsCount(state.medicines.length),
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const Spacer(),

//                     Text(
//                       S.of(context).medicinesSortBy,
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),

//                     Text(
//                       'Expiry date',
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),

//                     const SizedBox(width: 3),

//                     Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       size: 18,
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),

//         /// Medicines
//         SliverPadding(
//           padding: const EdgeInsets.symmetric(horizontal: 33),
//           sliver: SliverList.separated(
//             itemCount: state.medicines.length,
//             separatorBuilder: (_, __) {
//               return const SizedBox(height: 11);
//             },
//             itemBuilder: (context, index) {
//               final medicine = state.medicines[index];

//               final status = context.read<MedicineCubit>().getMedicineStatus(
//                 medicine,
//               );

//               return MedicineCard(
//                 name: medicine.name,
//                 type: medicine.type,
//                 remaining: medicine.quantity,
//                 expiry: _formatExpiryDate(medicine.expiryDate),
//                 addedBy: medicine.addedBy,
//                 status: statusTitle(context, status),
//               );
//             },
//           ),
//         ),

//         const SliverToBoxAdapter(child: SizedBox(height: 30)),
//       ],
//     );
//   }

//   String _formatExpiryDate(DateTime date) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];

//     return '${months[date.month - 1]} ${date.year}';
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import 'package:medicine_cabinet/core/constants/app_colors.dart';
// import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
// import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
// import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
// import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
// import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';
// import 'package:medicine_cabinet/generated/l10n.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:medicine_cabinet/core/constants/app_strings.dart';

// class MedicinesScreen extends StatefulWidget {
//   final String householdId;
//   const MedicinesScreen({super.key, required this.householdId});

//   @override
//   State<MedicinesScreen> createState() => _MedicinesScreenState();
// }

// class _MedicinesScreenState extends State<MedicinesScreen> {
//   final TextEditingController searchController = TextEditingController();

//   MedicineSort selectedSort = MedicineSort.expiryDate;

//   final List<MedicineFilter> filters = [
//     MedicineFilter.all,
//     MedicineFilter.expiringSoon,
//     MedicineFilter.lowStock,
//     MedicineFilter.expired,
//   ];

//   @override
//   void initState() {
//     super.initState();

//     context.read<MedicineCubit>().getMedicines(widget.householdId);
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<MedicineCubit, MedicineState>(
//           builder: (context, state) {
//             if (state is MedicineLoadingState) {
//               return _buildMedicinesContent(
//                 context,
//                 MedicineSuccessState(
//                   medicines: const [],
//                   selectedFilter: MedicineFilter.all,
//                 ),
//                 isLoading: true,
//               );
//             }

//             if (state is MedicineErrorState) {
//               return Center(
//                 child: Text(state.message, style: theme.textTheme.bodyMedium),
//               );
//             }

//             if (state is MedicineSuccessState) {
//               return _buildMedicinesContent(context, state);
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicinesContent(
//     BuildContext context,
//     MedicineSuccessState state, {
//     bool isLoading = false,
//   }) {
//     final theme = Theme.of(context);
//     final l10n = S.of(context);

//     final medicines = [...state.medicines];

//     _sortMedicines(medicines);

//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: const EdgeInsets.fromLTRB(33, 28, 33, 0),
//           sliver: SliverToBoxAdapter(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Title
//                 Text(
//                   l10n.medicinesTitle,
//                   style: theme.textTheme.headlineMedium?.copyWith(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w800,
//                     letterSpacing: -0.5,
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 /// Search
//                 CustomTextFormField(
//                   controller: searchController,
//                   hintText: l10n.medicinesSearchHint,
//                   hintTextColor: theme.brightness == Brightness.dark
//                       ? AppColors.textMutedDark
//                       : AppColors.textMutedLight,
//                   onChanged: (value) {
//                     // Search logic later.
//                   },
//                   prefixIcon: Icon(
//                     Icons.search_rounded,
//                     color: theme.brightness == Brightness.dark
//                         ? AppColors.textMutedDark
//                         : AppColors.textMutedLight,
//                     size: 20,
//                   ),
//                   suffixWidget: Icon(
//                     Icons.tune_rounded,
//                     color: theme.brightness == Brightness.dark
//                         ? AppColors.textMutedDark
//                         : AppColors.textMutedLight,
//                     size: 20,
//                   ),
//                   borderRadius: BorderRadius.circular(22),
//                 ),

//                 const SizedBox(height: 14),

//                 /// Filters
//                 SizedBox(
//                   height: 38,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: filters.length,
//                     separatorBuilder: (_, __) {
//                       return const SizedBox(width: 9);
//                     },
//                     itemBuilder: (context, index) {
//                       final filter = filters[index];

//                       return MedicineFilterChip(
//                         title: getMedicineFilterTitle(context, filter),
//                         isSelected: state.selectedFilter == filter,
//                         onTap: () {
//                           context.read<MedicineCubit>().filterMedicines(filter);
//                         },
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// Items + Sort
//                 Row(
//                   children: [
//                     Text(
//                       l10n.medicinesItemsCount(medicines.length),
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const Spacer(),

//                     InkWell(
//                       onTap: () {
//                         _showSortBottomSheet(context);
//                       },
//                       borderRadius: BorderRadius.circular(8),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             l10n.medicinesSortLabelCurrent(
//                               getMedicineSortTitle(context, selectedSort),
//                             ),
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const SizedBox(width: 2),
//                           Icon(
//                             Icons.keyboard_arrow_down_rounded,
//                             size: 18,
//                             color: theme.colorScheme.onSurfaceVariant,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),

//         /// Medicines
//         SliverPadding(
//           padding: const EdgeInsets.symmetric(horizontal: 33),
//           sliver: SliverList.separated(
//             itemCount: isLoading ? 5 : medicines.length,
//             separatorBuilder: (_, __) {
//               return const SizedBox(height: 11);
//             },
//             itemBuilder: (context, index) {
//               if (isLoading) {
//                 return Skeletonizer(
//                   enabled: true,
//                   child: MedicineCard(
//                     name: AppStrings.dummyMedicineName,
//                     type: AppStrings.dummyMedicineType,
//                     remaining: 12,
//                     expiry: AppStrings.dummyMedicineExpiry,
//                     addedBy: AppStrings.dummyMedicineAddedBy,
//                     status: AppStrings.dummyMedicineStatus,
//                   ),
//                 );
//               }

//               final medicine = medicines[index];

//               final status = context.read<MedicineCubit>().getMedicineStatus(
//                 medicine,
//               );

//               return MedicineCard(
//                 imageUrl: medicine.imageUrl,
//                 name: medicine.name,
//                 type: medicine.type,
//                 remaining: medicine.quantity,
//                 expiry: _formatExpiryDate(context, medicine.expiryDate),
//                 addedBy: medicine.addedBy,
//                 status: getMedicineStatusTitle(context, status),
//               );
//             },
//           ),
//         ),

//         const SliverToBoxAdapter(child: SizedBox(height: 30)),
//       ],
//     );
//   }

//   void _sortMedicines(List medicines) {
//     switch (selectedSort) {
//       case MedicineSort.expiryDate:
//         medicines.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
//         break;

//       case MedicineSort.name:
//         medicines.sort(
//           (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
//         );
//         break;

//       case MedicineSort.quantity:
//         medicines.sort((a, b) => a.quantity.compareTo(b.quantity));
//         break;

//       case MedicineSort.recentlyAdded:
//         medicines.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//         break;
//     }
//   }

//   void _showSortBottomSheet(BuildContext context) {
//     MedicineSort temporarySort = selectedSort;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) {
//         final theme = Theme.of(context);
//         final l10n = S.of(context);

//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Container(
//               padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
//               decoration: BoxDecoration(
//                 color: theme.scaffoldBackgroundColor,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(28),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   /// Handle
//                   Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.outline,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),

//                   const SizedBox(height: 18),

//                   /// Title
//                   Align(
//                     alignment: AlignmentDirectional.centerStart,
//                     child: Text(
//                       l10n.medicinesSortBy,
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   _buildSortOption(
//                     context: context,
//                     title: l10n.medicinesSortOptionExpiry,
//                     value: MedicineSort.expiryDate,
//                     selectedValue: temporarySort,
//                     onTap: () {
//                       setModalState(() {
//                         temporarySort = MedicineSort.expiryDate;
//                       });
//                     },
//                   ),

//                   _buildSortOption(
//                     context: context,
//                     title: l10n.medicinesSortOptionName,
//                     value: MedicineSort.name,
//                     selectedValue: temporarySort,
//                     onTap: () {
//                       setModalState(() {
//                         temporarySort = MedicineSort.name;
//                       });
//                     },
//                   ),

//                   _buildSortOption(
//                     context: context,
//                     title: l10n.medicinesSortOptionQuantity,
//                     value: MedicineSort.quantity,
//                     selectedValue: temporarySort,
//                     onTap: () {
//                       setModalState(() {
//                         temporarySort = MedicineSort.quantity;
//                       });
//                     },
//                   ),

//                   _buildSortOption(
//                     context: context,
//                     title: l10n.medicinesSortOptionRecentlyAdded,
//                     value: MedicineSort.recentlyAdded,
//                     selectedValue: temporarySort,
//                     onTap: () {
//                       setModalState(() {
//                         temporarySort = MedicineSort.recentlyAdded;
//                       });
//                     },
//                   ),

//                   const SizedBox(height: 12),

//                   /// Apply
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedSort = temporarySort;
//                         });

//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         l10n.commonApply,
//                         style: const TextStyle(fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSortOption({
//     required BuildContext context,
//     required String title,
//     required MedicineSort value,
//     required MedicineSort selectedValue,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);

//     final bool isSelected = value == selectedValue;

//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 47,
//         decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: theme.dividerColor)),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             if (isSelected)
//               Icon(
//                 Icons.check_rounded,
//                 size: 20,
//                 color: theme.colorScheme.primary,
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatExpiryDate(BuildContext context, DateTime date) {
//     final locale = Localizations.localeOf(context).toString();

//     return DateFormat('MMM yyyy', locale).format(date);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/Medicine_sort_option.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/date_formatter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicinesScreen extends StatefulWidget {
  final String householdId;

  const MedicinesScreen({super.key, required this.householdId});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final TextEditingController searchController = TextEditingController();

  MedicineSort selectedSort = MedicineSort.expiryDate;

  final List<MedicineFilter> filters = [
    MedicineFilter.all,
    MedicineFilter.expiringSoon,
    MedicineFilter.lowStock,
    MedicineFilter.expired,
  ];

  @override
  void initState() {
    super.initState();

    context.read<MedicineCubit>().getMedicines(widget.householdId);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MedicineCubit, MedicineState>(
          builder: (context, state) {
            if (state is MedicineLoadingState) {
              return _buildMedicinesContent(
                context,
                MedicineSuccessState(
                  medicines: const [],
                  selectedFilter: MedicineFilter.all,
                ),
                isLoading: true,
              );
            }

            if (state is MedicineErrorState) {
              return Center(
                child: Text(state.message, style: theme.textTheme.bodyMedium),
              );
            }

            if (state is MedicineSuccessState) {
              return _buildMedicinesContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMedicinesContent(
    BuildContext context,
    MedicineSuccessState state, {
    bool isLoading = false,
  }) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    final medicines = [...state.medicines];

    _sortMedicines(medicines);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(33, 28, 33, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  l10n.medicinesTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 16),

                /// Search
                CustomTextFormField(
                  controller: searchController,
                  hintText: l10n.medicinesSearchHint,
                  hintTextColor: theme.brightness == Brightness.dark
                      ? AppColors.textMutedDark
                      : AppColors.textMutedLight,
                  onChanged: (value) {
                    // Search logic later.
                  },
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                    size: 20,
                  ),
                  suffixWidget: Icon(
                    Icons.tune_rounded,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                    size: 20,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),

                const SizedBox(height: 14),

                /// Filters
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 9);
                    },
                    itemBuilder: (context, index) {
                      final filter = filters[index];

                      return MedicineFilterChip(
                        title: getMedicineFilterTitle(context, filter),
                        isSelected: state.selectedFilter == filter,
                        onTap: () {
                          context.read<MedicineCubit>().filterMedicines(filter);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// Items + Sort
                Row(
                  children: [
                    Text(
                      l10n.medicinesItemsCount(medicines.length),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    InkWell(
                      onTap: () {
                        _showSortBottomSheet(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.medicinesSortLabelCurrent(
                              getMedicineSortTitle(context, selectedSort),
                            ),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        /// Medicines
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          sliver: SliverList.separated(
            itemCount: isLoading ? 5 : medicines.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 11);
            },
            itemBuilder: (context, index) {
              if (isLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: MedicineCard(
                    name: AppStrings.dummyMedicineName,
                    type: AppStrings.dummyMedicineType,
                    remaining: 12,
                    expiry: AppStrings.dummyMedicineExpiry,
                    addedBy: AppStrings.dummyMedicineAddedBy,
                    status: AppStrings.dummyMedicineStatus,
                  ),
                );
              }

              final medicine = medicines[index];

              final status = context.read<MedicineCubit>().getMedicineStatus(
                medicine,
              );

              return MedicineCard(
                imageUrl: medicine.imageUrl,
                name: medicine.name,
                type: medicine.type,
                remaining: medicine.quantity,
                expiry: formatExpiryDate(context, medicine.expiryDate),
                addedBy: medicine.addedBy,
                status: getMedicineStatusTitle(context, status),
              );
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }

  void _sortMedicines(List medicines) {
    switch (selectedSort) {
      case MedicineSort.expiryDate:
        medicines.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
        break;

      case MedicineSort.name:
        medicines.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
        break;

      case MedicineSort.quantity:
        medicines.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;

      case MedicineSort.recentlyAdded:
        medicines.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
  }

  void _showSortBottomSheet(BuildContext context) {
    MedicineSort temporarySort = selectedSort;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
        final l10n = S.of(context);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Title
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.medicinesSortBy,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  MedicineSortOption(
                    title: l10n.medicinesSortOptionExpiry,
                    value: MedicineSort.expiryDate,
                    selectedValue: temporarySort,
                    onTap: () {
                      setModalState(() {
                        temporarySort = MedicineSort.expiryDate;
                      });
                    },
                  ),

                  MedicineSortOption(
                    title: l10n.medicinesSortOptionName,
                    value: MedicineSort.name,
                    selectedValue: temporarySort,
                    onTap: () {
                      setModalState(() {
                        temporarySort = MedicineSort.name;
                      });
                    },
                  ),

                  MedicineSortOption(
                    title: l10n.medicinesSortOptionQuantity,
                    value: MedicineSort.quantity,
                    selectedValue: temporarySort,
                    onTap: () {
                      setModalState(() {
                        temporarySort = MedicineSort.quantity;
                      });
                    },
                  ),

                  MedicineSortOption(
                    title: l10n.medicinesSortOptionRecentlyAdded,
                    value: MedicineSort.recentlyAdded,
                    selectedValue: temporarySort,
                    onTap: () {
                      setModalState(() {
                        temporarySort = MedicineSort.recentlyAdded;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Apply
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSort = temporarySort;
                        });

                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.commonApply,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
