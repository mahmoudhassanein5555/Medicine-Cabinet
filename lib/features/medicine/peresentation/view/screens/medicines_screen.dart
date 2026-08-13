import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import '../widgets/medicine_card.dart';
import '../widgets/medicine_filter_chip.dart';

// import your custom text field

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final TextEditingController searchController = TextEditingController();

  int selectedFilter = 0;

  final List<String> filters = ['All', 'Expiring soon', 'Low stock'];

  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Panadol',
      'type': 'Tablets',
      'remaining': 12,
      'expiry': 'Mar 2027',
      'addedBy': 'Ahmed',
      'status': 'Expiring',
    },
    {
      'name': 'Amoxicillin',
      'type': 'Capsules',
      'remaining': 20,
      'expiry': 'Nov 2026',
      'addedBy': 'Ahmed',
      'status': 'Healthy',
    },
    {
      'name': 'Vitamin D',
      'type': 'Tablets',
      'remaining': 3,
      'expiry': 'Aug 2028',
      'addedBy': 'Mom',
      'status': 'Low stock',
    },
    {
      'name': 'Brufen',
      'type': 'Tablets',
      'remaining': 15,
      'expiry': 'Jan 2027',
      'addedBy': 'Dad',
      'status': 'Healthy',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: CustomScrollView(
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

                    /// Search
                    CustomTextFormField(
                      controller: searchController,
                      hintText: 'Search medicines...',
                      hintTextColor: const Color(0xFF9AA6A2),
                      onChanged: (value) {
                        // Later:
                        // context
                        //     .read<MedicinesCubit>()
                        //     .searchMedicines(value ?? '');
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

                    /// Filters
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        separatorBuilder: (_, __) {
                          return const SizedBox(width: 9);
                        },
                        itemBuilder: (context, index) {
                          return MedicineFilterChip(
                            title: filters[index],
                            isSelected: selectedFilter == index,
                            onTap: () {
                              setState(() {
                                selectedFilter = index;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Scroll indicator
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

                    /// Items + Sort
                    Row(
                      children: [
                        const Text(
                          '24 items',
                          style: TextStyle(
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

            /// Medicines
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              sliver: SliverList.separated(
                itemCount: medicines.length,
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 11);
                },
                itemBuilder: (context, index) {
                  final medicine = medicines[index];

                  return MedicineCard(
                    name: medicine['name'],
                    type: medicine['type'],
                    remaining: medicine['remaining'],
                    expiry: medicine['expiry'],
                    addedBy: medicine['addedBy'],
                    status: medicine['status'],
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
