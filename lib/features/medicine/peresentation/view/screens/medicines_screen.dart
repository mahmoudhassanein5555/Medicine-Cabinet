import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_error.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_empty.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_list.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicines_loading.dart';
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
    final medicines = state.medicines;

    return CustomScrollView(
      slivers: [
        /// Header + Search + Items Count
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

                SizedBox(height: 18.h),

                // /// Items count
                // Text(
                //   l10n.medicinesItemsCount(medicines.length),
                //   style: theme.textTheme.bodyMedium?.copyWith(
                //     fontSize: 13.5.sp,
                //     fontWeight: FontWeight.w600,
                //     color: theme.brightness == Brightness.dark
                //         ? AppColors.textSecondaryDark
                //         : AppColors.textSecondaryLight,
                //   ),
                // ),

                // SizedBox(height: 16.h),
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
