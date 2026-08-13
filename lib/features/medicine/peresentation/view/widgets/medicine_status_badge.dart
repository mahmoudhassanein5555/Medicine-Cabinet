import 'package:flutter/material.dart';

class MedicineStatusBadge extends StatelessWidget {
  const MedicineStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isHealthy = status == 'Healthy';

    final Color backgroundColor = isHealthy
        ? const Color(0xFFE1F3EC)
        : const Color(0xFFFFEBD3);

    final Color textColor = isHealthy
        ? const Color(0xFF22906F)
        : const Color(0xFFEF941C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
