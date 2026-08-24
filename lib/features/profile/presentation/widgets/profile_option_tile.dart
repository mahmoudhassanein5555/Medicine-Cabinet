import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.showDivider = true,
    this.color,
  });

  final String title;
  final VoidCallback onTap;
  final String? trailingText;
  final bool showDivider;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          trailing: trailingText != null
              ? Text(
            trailingText!,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
          )
              : Icon(
            Icons.chevron_right,
            color: colorScheme.onSurfaceVariant,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.8,
            indent: 16,
            endIndent: 16,
            color: colorScheme.outline,
          ),
      ],
    );
  }
}