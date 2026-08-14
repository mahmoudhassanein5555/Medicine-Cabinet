import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../generated/l10n.dart';

class HouseholdScreen extends StatelessWidget {
  const HouseholdScreen({super.key, this.onJoinPressed, this.onCreatePressed});

  final VoidCallback? onJoinPressed;
  final VoidCallback? onCreatePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    l10n.householdSetupTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    l10n.householdSetupDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Animation
                  SizedBox(
                    width: double.infinity, // تم تصحيحها من .infinity لـ double.infinity
                    height: 250,
                    child: Lottie.asset(
                      'assets/animations/household_screen.json',
                      repeat: true,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Household ID Label
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.householdIdLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Household ID Field (هياخد خصائصه أوتوماتيكياً من الـ InputDecorationTheme)
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_outlined),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Join Button (هياخد تصميمه من elevatedButtonTheme)
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: onJoinPressed,
                      child: Text(l10n.householdJoinButton),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorScheme.outline,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.householdOr,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Create Button (هياخد تصميمه من outlinedButtonTheme)
                  SizedBox(
                    child: OutlinedButton(
                      onPressed: onCreatePressed,
                      child: Text(l10n.householdCreateButton),
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