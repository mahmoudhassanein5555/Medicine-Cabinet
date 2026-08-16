import 'package:flutter/material.dart';

class MedicineDetailsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onEdit;

  const MedicineDetailsHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colors.onSurface,
            size: 20,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colors.onSurface,
            ),
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: Icon(Icons.edit_outlined, color: colors.onSurface),
        ),
      ],
    );
  }
}
