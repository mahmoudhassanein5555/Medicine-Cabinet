import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicineListSkeleton extends StatelessWidget {
  const MedicineListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Bone.square(
                  size: 64,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Bone.text(
                        words: 2,
                      ),

                      const SizedBox(height: 8),

                      Bone.text(
                        words: 1,
                      ),

                      const SizedBox(height: 8),

                      Bone.text(
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