import 'package:flutter/material.dart';
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.radius,
  });

  final String name;
  final String? photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;

    if (!hasPhoto) {
      return _PersonIconAvatar(radius: radius, colorScheme: colorScheme);
    }

    return ClipOval(
      child: Image.network(
        photoUrl!,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return CircleAvatar(
            radius: radius,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            child: SizedBox(
              width: radius * 0.7,
              height: radius * 0.7,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            _PersonIconAvatar(radius: radius, colorScheme: colorScheme),
      ),
    );
  }
}

class _PersonIconAvatar extends StatelessWidget {
  const _PersonIconAvatar({required this.radius, required this.colorScheme});

  final double radius;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primary,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: radius * 1.1,
      ),
    );
  }
}