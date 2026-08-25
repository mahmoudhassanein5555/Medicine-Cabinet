import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseholdMedicineImage extends StatelessWidget {
  const HouseholdMedicineImage({
    super.key,
    required this.imageUrl,
    required this.colorScheme,
  });

  final String? imageUrl;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 56.r,
        height: 56.r,
        color: colorScheme.primary.withValues(alpha: 0.1),
        child: url != null && url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.medication_outlined, color: colorScheme.primary, size: 24.r),
              )
            : Icon(Icons.medication_outlined, color: colorScheme.primary, size: 24.r),
      ),
    );
  }
}
