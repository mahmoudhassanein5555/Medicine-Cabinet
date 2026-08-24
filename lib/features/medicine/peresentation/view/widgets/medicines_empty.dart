import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class EmptyMedicines extends StatelessWidget {
  const EmptyMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 20),
        child: Column(
          children: [
            Lottie.asset(
              AppAssets.nodata,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

            Text(
              l10n.medicinesNoMedicines,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
