import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/core/utils/shared_prefs_local_data_source.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/attention_needed_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/home_empty_medicines_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/home_header_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/household_members_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/recently_added_section_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/scan_action_card_widget.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/stat_counter_cards_widget.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/household_members_screen.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view_model/household_cubit.dart';

class HomeContentView extends StatefulWidget {
  final UserEntity user;
  final CabinetSummaryEntity summary;
  final List<MemberEntity> members;
  final Future<void> Function() onRefresh;
  final VoidCallback? onScanPressed;
  final void Function(int index)? onNavigateToTab;

  const HomeContentView({
    super.key,
    required this.user,
    required this.summary,
    required this.members,
    required this.onRefresh,
    this.onScanPressed,
    this.onNavigateToTab,
  });

  @override
  State<HomeContentView> createState() => _HomeContentViewState();
}

class _HomeContentViewState extends State<HomeContentView> {
  late final HouseholdLocalDataSource _householdLocalDataSource;

  @override
  void initState() {
    super.initState();

    _householdLocalDataSource = getIt<HouseholdLocalDataSource>();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: AppColors.primaryLight,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        children: [
          HomeHeaderWidget(
            user: widget.user,
          ),

          SizedBox(height: 20.h),

          StatCounterCardsWidget(
            summary: widget.summary,
            onMedicinesTap: () {
              widget.onNavigateToTab?.call(1);
            },
            onExpiringTap: () {
              widget.onNavigateToTab?.call(2);
            },
            onLowStockTap: () {
              widget.onNavigateToTab?.call(2);
            },
          ),

          SizedBox(height: 20.h),

          ScanActionCardWidget(
            onScanPressed: widget.onScanPressed,
          ),

          SizedBox(height: 24.h),

          if (widget.summary.hasAttentionNeeded) ...[
            AttentionNeededSectionWidget(
              summary: widget.summary,
              onSeeAllTap: () {
                widget.onNavigateToTab?.call(2);
              },
              onMedicineTap: (medicine) {},
            ),

            SizedBox(height: 18.h),
          ],

          if (widget.summary.hasRecentlyAdded) ...[
            RecentlyAddedSectionWidget(
              summary: widget.summary,
              onSeeAllTap: () {
                widget.onNavigateToTab?.call(1);
              },
              onMedicineTap: (medicine) {},
            ),

            SizedBox(height: 18.h),
          ],

          if (widget.members.isNotEmpty) ...[
            HouseholdMembersSectionWidget(
              members: widget.members,
              onManageTap: _openHouseholdMembers,
              onMemberTap: (member) {},
            ),

            SizedBox(height: 20.h),
          ],

          if (widget.summary.totalCount == 0) ...[
            const HomeEmptyMedicinesWidget(),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }

  void _openHouseholdMembers() {
    final householdId = _householdLocalDataSource.getHouseholdId();

    final userId = getIt<CacheHelper>().getData(
      key: AppKeys.userId,
    );

    if (householdId == null || householdId.isEmpty) {
      return;
    }

    if (userId == null || userId.isEmpty) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => getIt<HouseholdCubit>(),
          child: HouseholdMembersScreen(
            userId: userId,
            householdId: householdId,
          ),
        ),
      ),
    );
  }
}