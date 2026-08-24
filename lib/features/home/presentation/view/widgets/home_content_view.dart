import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/attention_needed_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/home_header_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/household_members_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/recently_added_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/scan_action_card_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/stat_counter_cards_widget.dart';

class HomeContentView extends StatelessWidget {
  final UserEntity user;
  final CabinetSummaryEntity summary;
  final List<MemberEntity> members;
  final Future<void> Function() onRefresh;
  final VoidCallback? onScanPressed;

  const HomeContentView({
    super.key,
    required this.user,
    required this.summary,
    required this.members,
    required this.onRefresh,
    this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primaryLight,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        children: [
          HomeHeaderWidget(user: user),
          SizedBox(height: 20.h),
          StatCounterCardsWidget(
            summary: summary,
            onMedicinesTap: () {},
            onExpiringTap: () {},
            onLowStockTap: () {},
          ),
          SizedBox(height: 20.h),
          ScanActionCardWidget(onScanPressed: onScanPressed),
          SizedBox(height: 24.h),
          if (summary.hasAttentionNeeded) ...[
            AttentionNeededSectionWidget(
              summary: summary,
              onSeeAllTap: () {},
              onMedicineTap: (medicine) {},
            ),
            SizedBox(height: 18.h),
          ],
          if (summary.hasRecentlyAdded) ...[
            RecentlyAddedSectionWidget(
              summary: summary,
              onSeeAllTap: () {},
              onMedicineTap: (medicine) {},
            ),
            SizedBox(height: 18.h),
          ],
          if (members.isNotEmpty) ...[
            HouseholdMembersSectionWidget(
              members: members,
              onManageTap: () {},
              onMemberTap: (member) {},
            ),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }
}
