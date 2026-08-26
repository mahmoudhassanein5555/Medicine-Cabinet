import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/member_card.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MemberSelectorSection extends StatelessWidget {
  const MemberSelectorSection({
    super.key,
    required this.selectedMember,
    required this.onMemberSelected,
    this.members = const [],
    this.isLoading = false,
    this.errorMessage,
    this.onAddMemberTap,
  });

  final String selectedMember;
  final ValueChanged<String> onMemberSelected;
  final List<MemberEntity> members;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onAddMemberTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_pin_rounded,
                  size: 20.r,
                  color: primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  S.of(context).scanWhoIsThisFor,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).scanSelectProfile,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildContent(context, isDark, primaryColor),
      ],
    );
  }

  Widget _buildContent(BuildContext context, bool isDark, Color primaryColor) {
    if (isLoading) {
      return SizedBox(
        height: 104.h,
        child: Center(
          child: SizedBox(
            width: 28.w,
            height: 28.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return SizedBox(
        height: 104.h,
        child: Center(
          child: Text(
            errorMessage!,
            style: TextStyle(
              color: isDark ? AppColors.errorDark : AppColors.errorLight,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    if (members.isEmpty) {
      return SizedBox(
        height: 104.h,
        child: Center(
          child: Text(
            S.of(context).scanNoMembersFound,
            style: TextStyle(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontSize: 13.sp,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 104.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: members.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final member = members[index];
          final isSelected = selectedMember == member.name ||
              (member.id.isNotEmpty && selectedMember == member.id);
          return MemberCard(
            name: member.name,
            role: member.role,
            isSelected: isSelected,
            onTap: () => onMemberSelected(member.id),
            profileImage: member.photoUrl,
            id: member.id,
          );
        },
      ),
    );
  }
}



