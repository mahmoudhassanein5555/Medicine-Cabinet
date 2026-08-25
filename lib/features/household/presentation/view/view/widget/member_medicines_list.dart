import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/features/household/domain/entity/medicine_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../view_model/household_cubit.dart';
import '../../view_model/household_state.dart';
import 'medicine_card.dart';

class MemberMedicinesList extends StatelessWidget {
  const MemberMedicinesList({super.key});

  static final List<MedicineEntity> _placeholderMedicines = List.generate(
    3,
    (index) => MedicineEntity(
      id: 'placeholder_$index',
      name: 'Medicine Name',
      type: 'Type',
      quantity: 10,
      ownerId: '',
      addedBy: '',
      expiryDate: DateTime.now().add(const Duration(days: 200)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdCubit, HouseholdState>(
      builder: (context, state) {
        if (state is GetMemberMedicinesLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildMedicinesColumn(_placeholderMedicines),
          );
        }

        if (state is GetMemberMedicinesError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(
              child: Text(
                state.failure.getMessage(context),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          );
        }

        if (state is GetMemberMedicinesSuccess) {
          final medicines = state.medicines;

          if (medicines.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 250.h,
                  child: Lottie.asset(
                    'assets/animations/member_details_screen.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }
          return _buildMedicinesColumn(medicines);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMedicinesColumn(List<MedicineEntity> medicines) {
    return Column(
      children: [
        for (var i = 0; i < medicines.length; i++) ...[
          if (i > 0) SizedBox(height: 12.h),
          MedicineCard(medicine: medicines[i]),
        ],
      ],
    );
  }
}
