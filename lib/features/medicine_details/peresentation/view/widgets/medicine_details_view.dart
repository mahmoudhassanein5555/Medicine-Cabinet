import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_details_body.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_details_error.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicineDetailsView extends StatelessWidget {
  final String householdId;
  final String medicineId;

  const MedicineDetailsView({
    super.key,
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
            child: MedicineDetailsBody(medicine: _dummyMedicine()),
          );
        }

        if (state.status == MedicineDetailsStatus.error &&
            state.medicine == null) {
          return MedicineDetailsError(
            failure: state.failure,
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
            failure: state.failure,
            onRetry: () {
              cubit.getMedicineDetails(
                householdId: householdId,
                medicineId: medicineId,
              );
            },
          );
        }

        return MedicineDetailsBody(medicine: medicine);
      },
    );
  }
}
