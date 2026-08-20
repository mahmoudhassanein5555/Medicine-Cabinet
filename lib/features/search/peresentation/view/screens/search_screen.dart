import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/core/constants/app_strings.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/utils/medicine_localizations.dart';
import 'package:medicine_cabinet/core/utils/search_localizations.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/date_formatter.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_cubit.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_state.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  final String householdId;

  const SearchScreen({super.key, required this.householdId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: _SearchView(
        householdId: widget.householdId,
        searchController: searchController,
      ),
    );
  }
}

class _SearchView extends StatelessWidget {
  final String householdId;
  final TextEditingController searchController;

  const _SearchView({
    required this.householdId,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              _buildSearchField(context, l10n),

              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    if (state is SearchInitialState) {
                      return _buildInitialState(context, theme, l10n);
                    }

                    if (state is SearchLoadingState) {
                      return const _SearchLoadingList();
                    }

                    if (state is SearchErrorState) {
                      return _buildErrorState(context, state, theme);
                    }

                    if (state is SearchSuccessState) {
                      return _buildSuccessState(context, state, theme, l10n);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, S l10n) {
    return CustomTextFormField(
      controller: searchController,
      hintText: l10n.medicinesSearchHint,
      onChanged: (query) {
        context.read<SearchCubit>().onSearchChanged(
          householdId: householdId,
          query: query ?? '',
        );
      },
      prefixIcon: const Icon(Icons.search_rounded),
    );
  }

  Widget _buildInitialState(BuildContext context, ThemeData theme, S l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset(AppAssets.search, fit: BoxFit.contain),
          ),

          const SizedBox(height: 20),

          Text(
            l10n.searchStartTyping,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    SearchErrorState state,
    ThemeData theme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset(AppAssets.search, fit: BoxFit.contain),
          ),

          const SizedBox(height: 20),

          // Text(
          //   state.message,
          //   style: theme.textTheme.bodyMedium?.copyWith(
          //     fontWeight: FontWeight.w600,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    SearchSuccessState state,
    ThemeData theme,
    S l10n,
  ) {
    if (state.medicines.isEmpty) {
      return Center(
        child: Text(l10n.searchNoResults, style: theme.textTheme.bodyMedium),
      );
    }

    final cubit = context.read<SearchCubit>();

    return ListView.separated(
      itemCount: state.medicines.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 11);
      },
      itemBuilder: (context, index) {
        final medicine = state.medicines[index];

        final status = cubit.getMedicineStatus(medicine);

        return MedicineCard(
          imageUrl: medicine.imageUrl,
          name: medicine.name,
          type: medicine.type,
          remaining: medicine.quantity,
          expiry: formatExpiryDate(context, medicine.expiryDate),
          addedBy: medicine.addedBy,
          status: getSearchMedicineStatusTitle(context, status),
        );
      },
    );
  }
}

class _SearchLoadingList extends StatelessWidget {
  const _SearchLoadingList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 11);
      },
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: MedicineCard(
            name: AppStrings.dummyMedicineName,
            type: AppStrings.dummyMedicineType,
            remaining: 12,
            expiry: AppStrings.dummyMedicineExpiry,
            addedBy: AppStrings.dummyMedicineAddedBy,
            status: AppStrings.dummyMedicineStatus,
          ),
        );
      },
    );
  }
}
