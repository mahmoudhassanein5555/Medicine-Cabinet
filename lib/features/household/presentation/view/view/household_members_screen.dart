import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/household/domain/entity/household_member_entity.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/member_card.dart';
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

  Future<void> _openMemberDetails(
    BuildContext context,
    HouseholdMemberEntity member,
    bool canRemove,
  ) async {
    final cubit = context.read<HouseholdCubit>();

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => MemberDetailsScreen(
          member: member,
          householdId: widget.householdId,
          currentUserId: widget.userId,
          canRemoveMember: canRemove,
        ),
      ),
    );

    if (mounted && result == true) {
      await cubit.getHouseholdMembers(
        householdId: widget.householdId,
        currentUserId: widget.userId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocProvider(
      create: (_) => getIt<HouseholdCubit>()
        ..getHouseholdMembers(
          householdId: widget.householdId,
          currentUserId: widget.userId,
        ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.h),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      l10n.householdTitle,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: BlocBuilder<HouseholdCubit, HouseholdState>(
                    builder: (context, state) {
                      if (state is GetMembersLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: ListView.separated(
                            itemCount: _placeholderMembers.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: 14.h),
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
                            state.failure.getMessage(context),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }
                      if (state is GetMembersSuccess) {
                        final members = state.members;

                        if (members.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.householdNoMembersFound,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          );
                        }

                        final cubit = context.read<HouseholdCubit>();

                        return ListView.separated(
                          itemCount: members.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            final member = members[index];

                            final canRemove = cubit.canRemoveMember(
                              currentUserId: widget.userId,
                              memberId: member.id,
                              isCurrentUserAdmin: state.isCurrentUserAdmin,
                            );

                            return MemberCard(
                              member: member,
                              onTap: () async {
                                await _openMemberDetails(
                                  context,
                                  member,
                                  canRemove,
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
