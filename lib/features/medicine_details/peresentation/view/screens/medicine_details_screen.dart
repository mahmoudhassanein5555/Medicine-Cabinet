import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view/widgets/medicine_details_view.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_cubit.dart';

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
      child: MedicineDetailsView(
        householdId: householdId,
        medicineId: medicineId,
      ),
    );
  }
}
