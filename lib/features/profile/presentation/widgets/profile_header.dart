import 'package:flutter/material.dart';

import '../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
  });

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final firstLetter = profile.name.trim().isNotEmpty
        ? profile.name.trim()[0].toUpperCase()
        : '?';

    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: colorScheme.primary,
          backgroundImage: profile.photoUrl != null &&
              profile.photoUrl!.isNotEmpty
              ? NetworkImage(profile.photoUrl!)
              : null,
          child: profile.photoUrl == null || profile.photoUrl!.isEmpty
              ? Text(
            firstLetter,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          )
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                profile.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}