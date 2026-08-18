import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: SizedBox(
          width: double.infinity,
          height: 250,
          child: Lottie.asset(
            'assets/animations/empty.json',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}