import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/household/domain/entity/household_member_entity.dart';
import 'package:medicine_cabinet/features/household/presentation/view/screens/widget/member_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';
import 'member_details_screen.dart';

class HouseholdMembersScreen extends StatefulWidget {
  const HouseholdMembersScreen({
    super.key,
    required this.householdId,
    required this.userId,
  });

  final String householdId;
  final String userId;
  @override
  State<HouseholdMembersScreen> createState() => _HouseholdMembersScreenState();
}

class _HouseholdMembersScreenState extends State<HouseholdMembersScreen> {
  static final List<HouseholdMemberEntity> _placeholderMembers = List.generate(
    6,
    ((index) => HouseholdMemberEntity(
      id: 'placeholder',
      name: 'Member Name',
      email: 'member@email.com',
      role: 'member',
      medicineCount: 0,
    )),
  );
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocProvider(
      create: (_) =>
          getIt<HouseholdCubit>()
            ..getHouseholdMembers(householdId: widget.householdId),
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
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
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
                  child: BlocBuilder<HouseholdCubit, HouseholdState>(
                    builder: (context, state) {
                      if (state is GetMembersLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: ListView.separated(
                            itemCount: _placeholderMembers.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) => MemberCard(
                              member: _placeholderMembers[index],
                              onTap: () {},
                            ),
                          ),
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
                        final currentUser = members
                            .cast<HouseholdMemberEntity?>()
                            .firstWhere(
                              (member) => member?.id == widget.userId,
                              orElse: () => null,
                            );

                        final isCurrentUserAdmin = currentUser?.role == 'admin';

                        if (members.isEmpty) {
                          return const Center(
                            child: Text('No household members found'),
                          );
                        }

                        return ListView.separated(
                          itemCount: members.length,

                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final member = members[index];
                            return MemberCard(
                              member: member,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MemberDetailsScreen(
                                      member: member,
                                      householdId: widget.householdId,
                                      currentUserId: widget.userId,
                                      isCurrentUserAdmin: isCurrentUserAdmin,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
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
