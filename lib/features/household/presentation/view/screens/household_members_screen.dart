import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class HouseholdMembersScreen extends StatelessWidget {
  const HouseholdMembersScreen({
    super.key,
    this.onMemberPressed,
  });

  final void Function(String userId)? onMemberPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    final members = [
      _HouseholdMemberUiModel(
        id: 'ahmed',
        name: 'Ahmed',
        medicineCount: 8,
        color: Colors.teal,
      ),
      _HouseholdMemberUiModel(
        id: 'mom',
        name: 'Mom',
        medicineCount: 11,
        color: Colors.blue,
      ),
      _HouseholdMemberUiModel(
        id: 'dad',
        name: 'Dad',
        medicineCount: 5,
        color: Colors.deepPurple,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    l10n.householdTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Members
              Expanded(
                child: ListView.separated(
                  itemCount: members.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final member = members[index];

                    return _MemberCard(
                      member: member,
                      medicineText: l10n.householdMedicineCount(
                        member.medicineCount,
                      ),
                      onTap: () => onMemberPressed?.call(member.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.member,
    required this.medicineText,
    required this.onTap,
  });

  final _HouseholdMemberUiModel member;
  final String medicineText;
  final VoidCallback onTap; // تم التصحيح هنا لـ VoidCallback

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final initial = member.name.characters.first.toUpperCase();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 98,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colorScheme.outline,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: member.color,
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Member information
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      medicineText,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HouseholdMemberUiModel {
  const _HouseholdMemberUiModel({
    required this.id,
    required this.name,
    required this.medicineCount,
    required this.color,
  });

  final String id;
  final String name;
  final int medicineCount;
  final Color color;
}