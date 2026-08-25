import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/search/peresentation/view/widgets/search_input_field.dart';
import 'package:medicine_cabinet/features/search/peresentation/view/widgets/search_loading_list.dart';
import 'package:medicine_cabinet/features/search/peresentation/view/widgets/search_state_views.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_cubit.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_state.dart';

class SearchScreen extends StatefulWidget {
  final String householdId;

  const SearchScreen({super.key, required this.householdId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
                size: 24.r,
              ),
            ),
            title: Text(
              'Search In Medicines',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            centerTitle: true,
            backgroundColor:
                isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                children: [
                  SearchInputField(
                    controller: _searchController,
                    householdId: widget.householdId,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchStates>(
                      builder: (context, state) {
                        if (state is SearchInitialState) {
                          return const SearchInitialView();
                        }

                        if (state is SearchLoadingState) {
                          return const SearchLoadingList();
                        }

                        if (state is SearchErrorState) {
                          return SearchErrorStateView(
                            errorMessage: state.failure.getMessage(context),
                          );
                        }

                        if (state is SearchSuccessState) {
                          if (state.medicines.isEmpty) {
                            return const SearchEmptyView();
                          }
                          return SearchResultsList(
                            medicines: state.medicines,
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
      ),
    );
  }
}
