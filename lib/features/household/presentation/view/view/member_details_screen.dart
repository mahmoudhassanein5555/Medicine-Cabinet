import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/dialogs/app_dialogs.dart';
import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/household_member_entity.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';
import 'widget/info_card.dart';
import 'widget/member_avatar.dart';
import 'widget/member_medicines_list.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({
    super.key,
    required this.member,
    required this.householdId,
    required this.currentUserId,
    required this.canRemoveMember,
  });

  final HouseholdMemberEntity member;
  final String householdId;
  final String currentUserId;
  final bool canRemoveMember;

  Future<void> _confirmAndRemove(BuildContext context) async {
    final l10n = S.of(context);
    final memberName = member.name.isNotEmpty ? member.name : '';

    await AppDialogs.showCustomDialog(
      context: context,
      title: l10n.householdRemoveMemberTitle,
      content: l10n.householdRemoveMemberDesc(memberName),
      cancelText: l10n.commonCancel,
      confirmText: l10n.householdRemoveButton,
      titleIcon: Icons.delete_outline,
      onConfirm: () {
        context.read<HouseholdCubit>().removeMember(
          householdId: householdId,
          memberId: member.id,
          currentUserId: currentUserId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) =>
          getIt<HouseholdCubit>()
            ..getMemberMedicines(householdId: householdId, userId: member.id),
      child: BlocListener<HouseholdCubit, HouseholdState>(
        listener: (context, state) {
          if (state is RemoveMemberSuccess) {
            AppToast.showToast(
              context: context,
              title: l10n.householdMemberRemovedTitle,
              description: l10n.householdMemberRemovedDescription,
              type: ToastificationType.success,
            );
            Navigator.pop(context, true);
          }
          if (state is RemoveMemberError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: state.failure.getMessage(context),
              type: ToastificationType.error,
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18.h),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: colorScheme.onSurface,
                          size: 24.r,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            l10n.householdMemberDetails,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      if (canRemoveMember)
                        BlocBuilder<HouseholdCubit, HouseholdState>(
                          builder: (context, state) {
                            final isRemoving = state is RemoveMemberLoading;
                            return IconButton(
                              onPressed: isRemoving
                                  ? null
                                  : () => _confirmAndRemove(context),
                              icon: isRemoving
                                  ? SizedBox(
                                      width: 20.r,
                                      height: 20.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person_remove_outlined,
                                      color: Colors.red,
                                      size: 30.r,
                                    ),
                              tooltip: l10n.householdRemoveMemberTooltip,
                            );
                          },
                        )
                      else
                        SizedBox(width: 48.w),
                    ],
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),

                          MemberAvatar(
                            name: member.name,
                            photoUrl: member.photoUrl,
                            radius: 48.r,
                          ),

                          SizedBox(height: 10.h),
                          Text(
                            member.name.isNotEmpty
                                ? member.name
                                : l10n.commonUnnamed,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 22.sp,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          Text(
                            member.email.isNotEmpty
                                ? member.email
                                : l10n.commonNoEmail,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.medication_outlined,
                                  size: 16.r,
                                  color: colorScheme.primary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  l10n.medicineCount(member.medicineCount),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30.h),

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              l10n.memberInformation,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),

                          SizedBox(height: 14.h),

                          InfoCard(
                            icon: Icons.person_outline,
                            title: l10n.name,
                            value: member.name,
                          ),

                          SizedBox(height: 12.h),

                          InfoCard(
                            icon: Icons.email_outlined,
                            title: l10n.memberEmail,
                            value: member.email,
                          ),

                          SizedBox(height: 12.h),

                          InfoCard(
                            icon: Icons.medication_outlined,
                            title: l10n.medicines,
                            value: '${member.medicineCount}',
                          ),

                          SizedBox(height: 30.h),

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              l10n.memberMedicines,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),

                          SizedBox(height: 14.h),

                          MemberMedicinesList(householdId: householdId),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
