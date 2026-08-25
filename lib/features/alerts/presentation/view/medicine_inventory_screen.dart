import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'package:medicine_cabinet/features/alerts/presentation/view/widget/inventory_categories.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/medicine_list.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/medicine_list_skeleton.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entity/medicine_inventory_category.dart';
import '../view_model/alert_cubit.dart';
import '../view_model/alert_state.dart';

class MedicineInventoryScreen extends StatelessWidget {
  final String householdId;

  const MedicineInventoryScreen({super.key, required this.householdId});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocProvider(
      create: (_) =>
          getIt<AlertCubit>()..getHouseHoldMedicines(householdId: householdId),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AlertCubit, AlertState>(
            listener: (context, state) {
              if (state is AlertError) {
                AppToast.showToast(
                  context: context,
                  title: l10n.somethingWrong,
                  description: state.failure.getMessage(context),
                  type: ToastificationType.error,
                );
              }
            },
            builder: (context, state) {
              MedicineInventoryCategory selectedCategory =
                  MedicineInventoryCategory.all;

              if (state is AlertLoading) {
                selectedCategory = state.selectedCategory;
              }

              if (state is AlertSuccess) {
                selectedCategory = state.selectedCategory;
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    Text(
                      l10n.alertsTitle,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    InventoryCategories(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        context.read<AlertCubit>().changeCategory(category);
                      },
                    ),

                    SizedBox(height: 16.h),

                    Expanded(
                      child: switch (state) {
                        AlertLoading() => const MedicineListSkeleton(),

                        AlertSuccess() => MedicineList(
                          medicines: state.medicines,
                          householdId: householdId,
                        ),

                        _ => const SizedBox.shrink(),
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
