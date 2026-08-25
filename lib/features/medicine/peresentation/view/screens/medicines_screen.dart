import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_sort.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_error.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_empty.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_list.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_loading.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_sort_bottom_sheet.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';
import 'package:medicine_cabinet/features/search/peresentation/view/screens/search_screen.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

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

  void _sortMedicines(List<MedicineEntity> medicines) {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                return CustomScrollView(
                  slivers: [
                    MedicinesError(
                      message: state.failure.getMessage(context),
                      onRetry: () {
                        context.read<MedicineCubit>().getMedicines(
                              widget.householdId,
                            );
                      },
                    ),
                  ],
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
          padding: EdgeInsets.fromLTRB(33.w, 28.h, 33.w, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  l10n.medicinesTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 16.h),

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
                        size: 20.r,
                      ),
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                /// Filters
                SizedBox(
                  height: 38.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) => SizedBox(width: 9.w),
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

                SizedBox(height: 20.h),

                /// Items count + Sort
                Row(
                  children: [
                    Text(
                      l10n.medicinesItemsCount(medicines.length),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    InkWell(
                      onTap: () {
                        MedicinesSortBottomSheet.show(
                          context: context,
                          currentSort: selectedSort,
                          onSortSelected: (sort) {
                            setState(() {
                              selectedSort = sort;
                            });
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.medicinesSortLabelCurrent(
                              getMedicineSortTitle(context, selectedSort),
                            ),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18.r,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),

        /// Medicines list section
        if (isLoading)
          const MedicinesLoading()
        else if (medicines.isEmpty)
          const EmptyMedicines()
        else
          MedicinesList(
            medicines: medicines,
            householdId: householdId,
          ),

        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
      ],
    );
  }
}
