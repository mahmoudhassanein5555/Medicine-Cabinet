import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/household_member_entity.dart';
import '../view_model/household_cubit.dart';
import 'widget/info_card.dart';
import 'widget/member_avatar.dart';
import 'widget/member_medicines_list.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({
    super.key,
    required this.member,
    required this.householdId,
  });

  final HouseholdMemberEntity member;
  final String householdId;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) => getIt<HouseholdCubit>()
        ..getMemberMedicines(householdId: householdId, userId: member.id),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.householdMemberDetails,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        MemberAvatar(
                          name: member.name,
                          photoUrl: member.photoUrl,
                          radius: 48,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          member.name.isNotEmpty ? member.name : 'Unnamed',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          member.email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.brightness == Brightness.dark
                                ? const Color(0xFFB0B0B0)
                                : const Color(0xFF4A4A4A),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.medication_outlined,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${member.medicineCount} ${l10n.medicines}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.memberInformation,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        InfoCard(
                          icon: Icons.person_outline,
                          title: l10n.name,
                          value: member.name,
                        ),

                        const SizedBox(height: 12),

                        InfoCard(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: member.email,
                        ),

                        const SizedBox(height: 12),

                        InfoCard(
                          icon: Icons.medication_outlined,
                          title: l10n.medicines,
                          value: '${member.medicineCount}',
                        ),

                        const SizedBox(height: 30),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.memberMedicines,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        const MemberMedicinesList(),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
