import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final String householdId;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return CustomTextFormField(
      controller: controller,
      hintText: l10n.medicinesSearchHint,
      hintTextColor: theme.brightness == Brightness.dark
          ? AppColors.textMutedDark
          : AppColors.textMutedLight,
      onChanged: (query) {
        context.read<SearchCubit>().onSearchChanged(
          householdId: householdId,
          query: query ?? '',
        );
      },
      prefixIcon: Icon(
        Icons.search_rounded,
        color: theme.brightness == Brightness.dark
            ? AppColors.textMutedDark
            : AppColors.textMutedLight,
        size: 20.r,
      ),
      borderRadius: BorderRadius.circular(22.r),
    );
  }
}
