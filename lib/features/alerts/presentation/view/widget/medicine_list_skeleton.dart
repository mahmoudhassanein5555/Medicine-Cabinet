import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicineListSkeleton extends StatelessWidget {
  const MedicineListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Bone.square(
                  size: 64.r,
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Bone.text(
                        words: 2,
                      ),

                      SizedBox(height: 8.h),

                      const Bone.text(
                        words: 1,
                      ),

                      SizedBox(height: 8.h),

                      const Bone.text(
                        words: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}