import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/home_content_view.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/home_error_view.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_cubit.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_state.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  final String householdId;

  const HomeScreen({
    super.key,
    required this.userId,
    required this.householdId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<HomeCubit>().loadHomeData(
      userId: widget.userId,
      householdId: widget.householdId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return Skeletonizer(
                enabled: true,
                child: HomeContentView(
                  user: UserEntity(
                    email: "",
                    householdId: "",
                    name: "",
                    photoUrl: "",
                    createdAt: DateTime.now(),
                  ),
                  summary: CabinetSummaryEntity(
                    activeMedicines: [],
                    expiringSoonMedicines: [],
                    lowStockMedicines: [],
                    recentlyAddedMedicines: [],
                    totalCount: 0,
                    expiringSoonCount: 0,
                    lowStockCount: 0,
                  ),
                  members: const [],
                  onScanPressed: _handleScanMedicine,
                  onRefresh: () async {},
                ),
              );
            } else if (state is HomeError) {
              return HomeErrorView(
                errorMessage: state.failure.getMessage(context),
                onRetry: _loadData,
              );
            } else if (state is HomeSuccess) {
              return HomeContentView(
                user: state.user,
                summary: state.summary,
                members: state.members,
                onRefresh: () async {
                  await context.read<HomeCubit>().refresh();
                },
                onScanPressed: _handleScanMedicine,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _handleScanMedicine() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).homeScanCta),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
