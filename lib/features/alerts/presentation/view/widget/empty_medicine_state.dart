import 'package:flutter/material.dart';

class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty_medicines.png',
              height: 120,
            ),

            const SizedBox(height: 12),

            const Text(
              'No medicines found',
            ),
          ],
        ),
      ),
    );
  }
}