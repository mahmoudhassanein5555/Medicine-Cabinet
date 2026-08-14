import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_card.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_filter_chip.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_states.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<MedicineFilter> filters = [
    MedicineFilter.all,
    MedicineFilter.expiringSoon,
    MedicineFilter.lowStock,
    MedicineFilter.expired,
  ];

  @override
  void initState() {
    super.initState();

    context.read<MedicineCubit>().getMedicines();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String filterTitle(MedicineFilter filter) {
    switch (filter) {
      case MedicineFilter.all:
        return 'All';

      case MedicineFilter.expiringSoon:
        return 'Expiring soon';

      case MedicineFilter.lowStock:
        return 'Low stock';

      case MedicineFilter.expired:
        return 'Expired';
    }
  }

  String statusTitle(MedicineStatus status) {
    switch (status) {
      case MedicineStatus.healthy:
        return 'Healthy';

      case MedicineStatus.expiring:
        return 'Expiring';

      case MedicineStatus.lowStock:
        return 'Low stock';

      case MedicineStatus.expired:
        return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: BlocBuilder<MedicineCubit, MedicineState>(
          builder: (context, state) {
            if (state is MedicineLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MedicineErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is MedicineSuccessState) {
              return _buildMedicinesContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMedicinesContent(
    BuildContext context,
    MedicineSuccessState state,
  ) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(33, 28, 33, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Medicines',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF202A27),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 16),

                // Search
                CustomTextFormField(
                  controller: searchController,
                  hintText: 'Search medicines...',
                  hintTextColor: const Color(0xFF9AA6A2),
                  onChanged: (value) {
                    // Search logic can be added later.
                  },
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF9AA6A2),
                    size: 20,
                  ),
                  suffixWidget: const Icon(
                    Icons.tune_rounded,
                    color: Color(0xFF9AA6A2),
                    size: 20,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),

                const SizedBox(height: 14),

                // Filters
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 9);
                    },
                    itemBuilder: (context, index) {
                      final filter = filters[index];

                      return MedicineFilterChip(
                        title: filterTitle(filter),
                        isSelected: state.selectedFilter == filter,
                        onTap: () {
                          context.read<MedicineCubit>().filterMedicines(filter);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Scroll indicator
                Row(
                  children: [
                    const Icon(
                      Icons.chevron_left_rounded,
                      size: 20,
                      color: Color(0xFF8B918F),
                    ),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB4BAB8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: Color(0xFF8B918F),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Items + Sort
                Row(
                  children: [
                    Text(
                      '${state.medicines.length} items',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7D8784),
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      'Sort: ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252D2A),
                      ),
                    ),

                    const Text(
                      'Expiry date',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF252D2A),
                      ),
                    ),

                    const SizedBox(width: 3),

                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Color(0xFF69736F),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Medicines
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          sliver: SliverList.separated(
            itemCount: state.medicines.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 11);
            },
            itemBuilder: (context, index) {
              final medicine = state.medicines[index];

              final status = context.read<MedicineCubit>().getMedicineStatus(
                medicine,
              );

              return MedicineCard(
                name: medicine.name,
                type: medicine.type,
                remaining: medicine.quantity,
                expiry: _formatExpiryDate(medicine.expiryDate),
                addedBy: medicine.addedBy,
                status: statusTitle(status),
              );
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }

  String _formatExpiryDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }
}
