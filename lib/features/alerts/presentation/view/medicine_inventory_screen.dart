import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/inventory_categories.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/medicine_list.dart';

import '../../../../core/di/service_locator.dart';
import '../view_model/alert_cubit.dart';
import '../view_model/alert_state.dart';

class MedicineInventoryScreen extends StatelessWidget {
  final String householdId;

  const MedicineInventoryScreen({
    super.key,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AlertCubit>()
        ..getHouseHoldMedicines(
          householdId: householdId,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicine Cabinet'),
        ),
        body: BlocBuilder<AlertCubit, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AlertError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is AlertSuccess) {
              return Column(
                children: [
                  const SizedBox(height: 12),

                  InventoryCategories(
                    selectedCategory:
                    state.selectedCategory,
                    onCategorySelected: (category) {
                      context
                          .read<AlertCubit>()
                          .changeCategory(category);
                    },
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: MedicineList(
                      medicines: state.medicines,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}