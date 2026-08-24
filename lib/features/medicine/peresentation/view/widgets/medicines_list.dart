import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/date_formatter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicinesList extends StatelessWidget {
  final List medicines;

  const MedicinesList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineCubit>();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      sliver: SliverList.separated(
        itemCount: medicines.length,
        separatorBuilder: (_, __) => const SizedBox(height: 11),
        itemBuilder: (context, index) {
          final medicine = medicines[index];

          final status = cubit.getMedicineStatus(medicine);

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
    );
  }
}
