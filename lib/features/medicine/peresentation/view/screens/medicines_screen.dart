import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/Medicine_sort_option.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_error.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_empty.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_list.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_loading.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';
import 'package:medicine_cabinet/features/search/peresentation/view/screens/search_screen.dart';
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MedicineCubit, MedicineState>(
            builder: (context, state) {
              /// Loading
              if (state is MedicineLoadingState) {
                return _buildMedicinesContent(
                  context,
                  MedicineSuccessState(
                    medicines: const [],
                    selectedFilter: MedicineFilter.all,
                  ),
                  isLoading: true,
                  householdId: widget.householdId,
                );
              }

              /// Real error
              if (state is MedicineErrorState) {
                return MedicinesError(
                  message: state.message,
                  onRetry: () {
                    context.read<MedicineCubit>().getMedicines(
                      widget.householdId,
                    );
                  },
                );
              }

              /// Success
              if (state is MedicineSuccessState) {
                return _buildMedicinesContent(
                  context,
                  state,
                  householdId: widget.householdId,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMedicinesContent(
    BuildContext context,
    MedicineSuccessState state, {
    bool isLoading = false,
    required String householdId,
  }) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    final medicines = [...state.medicines];

    _sortMedicines(medicines);

    return CustomScrollView(
      slivers: [
        /// Header + Search + Filters + Sort
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen(householdId: householdId),
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: searchController,
                      hintText: l10n.medicinesSearchHint,
                      hintTextColor: theme.brightness == Brightness.dark
                          ? AppColors.textMutedDark
                          : AppColors.textMutedLight,
                      onChanged: (_) {},
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: theme.brightness == Brightness.dark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        size: 20,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
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

                /// Items count + Sort
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

        /// Medicines section
        if (isLoading)
          const MedicinesLoading()
        else if (medicines.isEmpty)
          const EmptyMedicines()
        else
          MedicinesList(medicines: medicines),

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

                  /// Expiry date
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

                  /// Name
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

                  /// Quantity
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

                  /// Recently added
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
