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

                  Text(
                    l10n.householdSetupTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    l10n.householdSetupDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: .infinity,
                    height: 250,
                    child: Lottie.asset(
                      'assets/animations/household_screen.json',
                      repeat: true,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.householdIdLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    decoration: InputDecoration(
                      hintText: l10n.householdIdHint,
                      prefixIcon: const Icon(Icons.home_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: onJoinPressed,
                      child: Text(l10n.householdJoinButton),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      const Expanded(child: Divider()),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.householdOr,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
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
