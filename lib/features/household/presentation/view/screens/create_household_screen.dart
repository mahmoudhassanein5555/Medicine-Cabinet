import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../generated/l10n.dart';

class CreateHouseholdScreen extends StatelessWidget {
  const CreateHouseholdScreen({
    super.key,
    this.onCreatePressed,
    this.onJoinPressed,
  });

  final VoidCallback? onCreatePressed;
  final VoidCallback? onJoinPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title
                  Text(
                    l10n.createHouseholdTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 10),

                  // Description
                  Text(
                    l10n.createHouseholdDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 16),

                  // Animation
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Lottie.asset(
                      'assets/animations/create_household_screen.json',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Household Name Label
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.householdNameLabel,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    decoration: InputDecoration(
                      hintText: l10n.householdNameHint,
                      prefixIcon: const Icon(Icons.home_outlined),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    child: ElevatedButton(
                      onPressed: onCreatePressed,
                      child: Text(l10n.householdCreateButton),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // OR
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.householdOr,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    child: OutlinedButton(
                      onPressed: onJoinPressed,
                      child: Text(l10n.householdJoinExistingButton),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// class _PermissionItem extends StatelessWidget {
//   const _PermissionItem({required this.text});
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Icon(Icons.check_circle_outline, size: 18, color: Colors.teal),
//         const SizedBox(width: 8),
//         Expanded(child: Text(text)),
//       ],
//     );
//   }
// }
