import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/household_member_entity.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';

class MemberDetailsScreen extends StatefulWidget {
  const MemberDetailsScreen({
    super.key,
    required this.member,
    required this.householdId,
  });

  final HouseholdMemberEntity member;
  final String householdId;
  @override
  State<MemberDetailsScreen> createState() => _MemberDetailsScreenState();
}

class _MemberDetailsScreenState extends State<MemberDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
final initial = member.name.isNotEmpty
? member.name.characters.first.toUpperCase()
: '?';



return BlocProvider(
      create: (_) => getIt<HouseholdCubit>()
        ..getHouseholdMembers(
          householdId: widget.householdId,
        ),
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
                  child: BlocBuilder(
                    builder: (context, state) {
                      if (state is GetMembersLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is GetMembersError) {
                        return Center(
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
if (state is GetMembersSuccess) {
final members = state.members;

if (members.isEmpty) {
return const Center(
child: Text(
'No household members found',
),
);
}
return

                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: colorScheme.primary,
                            child: Text(
                              widget.memberInitial,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            widget.memberName,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '${widget.medicinesCount} ${l10n.medicines}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
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

                          _InfoCard(
                            icon: Icons.person_outline,
                            title: l10n.name,
                            value: widget.memberName,
                          ),

                          const SizedBox(height: 12),

                          _InfoCard(
                            icon: Icons.medication_outlined,
                            title: l10n.medicines,
                            value: '${widget.medicinesCount}',
                          ),

                          const SizedBox(height: 30),

                          // Medicines Section Header
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

                          const _MedicineCard(
                            name: 'Panadol',
                            quantity: '2 boxes',
                            expiryDate: 'Dec 2026',
                          ),

                          const SizedBox(height: 12),

                          const _MedicineCard(
                            name: 'Vitamin C',
                            quantity: '1 bottle',
                            expiryDate: 'Mar 2027',
                          ),

                          const SizedBox(height: 12),

                          const _MedicineCard(
                            name: 'Omega 3',
                            quantity: '3 boxes',
                            expiryDate: 'Jan 2027',
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({
    required this.name,
    required this.quantity,
    required this.expiryDate,
  });

  final String name;
  final String quantity;
  final String expiryDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.medication_outlined, color: colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  quantity,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Expiry: $expiryDate',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
