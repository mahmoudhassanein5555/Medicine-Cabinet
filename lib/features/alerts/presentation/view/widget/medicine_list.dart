import 'package:flutter/material.dart';

import '../../../domain/entity/medicine_entity.dart';
import 'empty_medicine_state.dart';
import 'medicine_card.dart';

class MedicineList extends StatelessWidget {
  final List<MedicineEntity> medicines;

  const MedicineList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return const EmptyMedicineState();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: medicines.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        return MedicineCard(medicine: medicines[index]);
      },
    );
  }
}
