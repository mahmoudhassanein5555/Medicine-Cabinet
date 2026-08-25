import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/settings/app_settings_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class ProfileLanguageTile extends StatelessWidget {
  const ProfileLanguageTile({super.key, this.showDivider = true});

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.watch<AppSettingsCubit>();
    final currentLanguage = appSettings.state.locale.languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).profileLanguage,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentLanguage,
                  borderRadius: BorderRadius.circular(12.r),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(S.of(context).profileEnglish),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(S.of(context).profileArabic),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<AppSettingsCubit>().changeLanguage(
                      value == 'ar',
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurfaceVariant,
                    size: 24.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.8,
            indent: 16.w,
            endIndent: 16.w,
            color: colorScheme.outline,
          ),
      ],
    );
  }
}
