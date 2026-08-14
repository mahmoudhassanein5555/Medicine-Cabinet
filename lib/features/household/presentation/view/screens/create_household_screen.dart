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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    l10n.createHouseholdTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    l10n.createHouseholdDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: .infinity,
                    height: 250,
                    child: Lottie.asset(
                      'assets/animations/create_household_screen.json',
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.householdNameLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    decoration: InputDecoration(
                      hintText: l10n.householdNameHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green.withValues(alpha: 0.08),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         l10n.householdAdminTitle,
                  //         style: Theme.of(context).textTheme.bodyMedium
                  //             ?.copyWith(fontWeight: FontWeight.bold),
                  //       ),
                  //
                  //       const SizedBox(height: 12),
                  //
                  //       // _PermissionItem(text: l10n.householdPermissionAdd),
                  //       //
                  //       // const SizedBox(height: 8),
                  //       //
                  //       // _PermissionItem(text: l10n.householdPermissionManage),
                  //       //
                  //       // const SizedBox(height: 8),
                  //       //
                  //       // _PermissionItem(text: l10n.householdPermissionView),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 16),

                  /// Create button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: onCreatePressed,
                      child: Text(l10n.householdCreateButton),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.householdOr,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
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
