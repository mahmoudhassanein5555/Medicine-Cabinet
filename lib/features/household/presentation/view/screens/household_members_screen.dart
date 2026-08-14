import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';

class HouseholdMembersScreen extends StatefulWidget {
  const HouseholdMembersScreen({
    super.key,
    required this.householdId,
    this.onMemberPressed,
  });

  final String householdId;
  final void Function(String userId)? onMemberPressed;

  @override
  State<HouseholdMembersScreen> createState() => _HouseholdMembersScreenState();
}

class _HouseholdMembersScreenState extends State<HouseholdMembersScreen> {


  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);



    return BlocProvider(
      create: (_) => getIt<HouseholdCubit>()
        ..getUserHousehold(userId:  widget.householdId),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),

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

                Expanded(
                  child: BlocBuilder< HouseholdCubit,
                      HouseholdState>(builder: (context, state) {
                    if (state is GetHouseholdLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is GetHouseholdError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if(state is GetHouseholdSuccess){
                      final members =state.
                    }


                      },)
                  // ListView.separated(
                  //   itemCount: members.length,
                  //   separatorBuilder: (_, __) => const SizedBox(height: 14),
                  //   itemBuilder: (context, index) {
                  //     final member = members[index];
                  //
                  //     return _MemberCard(
                  //       member: member,
                  //       medicineText: l10n.householdMedicineCount(
                  //         member.medicineCount,
                  //       ),
                  //       onTap: () => onMemberPressed?.call(member.id),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
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
  final VoidCallback onTap;
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

