// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/di/service_locator.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../domain/entity/household_member_entity.dart';
// import '../../../domain/entity/medicine_entity.dart';
// import '../view_model/household_cubit.dart';
// import '../view_model/household_state.dart';
//
// class MemberDetailsScreen extends StatelessWidget {
//   const MemberDetailsScreen({
//     super.key,
//     required this.member,
//     required this.householdId,
//   });
//
//   final HouseholdMemberEntity member;
//   final String householdId;
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = S.of(context);
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     final initial = member.name.isNotEmpty ? member.name[0].toUpperCase() : '?';
//
//     return BlocProvider(
//       create: (_) =>
//       getIt<HouseholdCubit>()
//         ..getMemberMedicines(householdId: householdId, userId: member.id),
//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 18),
//
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: colorScheme.onSurface,
//                       ),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           l10n.householdMemberDetails,
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 48),
//                   ],
//                 ),
//
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 10),
//
//                         CircleAvatar(
//                           radius: 48,
//                           backgroundColor: colorScheme.primary,
//                           child: Text(
//                             initial,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 34,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 2),
//
//                         Text(
//                           member.name,
//                           style: theme.textTheme.headlineSmall?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//
//                         const SizedBox(height: 6),
//
//                         Text(
//                           '${member.medicineCount} ${l10n.medicines}',
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: colorScheme.onSurfaceVariant,
//                           ),
//                         ),
//
//                         const SizedBox(height: 30),
//
//                         Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Text(
//                             l10n.memberInformation,
//                             style: theme.textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 14),
//
//                         _InfoCard(
//                           icon: Icons.person_outline,
//                           title: l10n.name,
//                           value: member.name,
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         _InfoCard(
//                           icon: Icons.email_outlined,
//                           title: 'Email',
//                           value: member.email,
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         _InfoCard(
//                           icon: Icons.medication_outlined,
//                           title: l10n.medicines,
//                           value: '${member.medicineCount}',
//                         ),
//
//                         const SizedBox(height: 30),
//
//                         Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Text(
//                             l10n.memberMedicines,
//                             style: theme.textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 14),
//
//                         BlocBuilder<HouseholdCubit, HouseholdState>(
//                           builder: (context, state) {
//                             if (state is GetMemberMedicinesLoading) {
//                               return const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 24),
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               );
//                             }
//
//                             if (state is GetMemberMedicinesError) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 24,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     state.message,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               );
//                             }
//
//                             if (state is GetMemberMedicinesSuccess) {
//                               final medicines = state.medicines;
//
//                               if (medicines.isEmpty) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 24,
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       'No medicines found',
//                                       style: theme.textTheme.bodyMedium
//                                           ?.copyWith(
//                                         color: colorScheme.onSurfaceVariant,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                               return ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: medicines.length,
//                                 separatorBuilder: (_, __) =>
//                                 const SizedBox(height: 12),
//                                 itemBuilder: (context, index) {
//                                   return _MedicineCard(
//                                     medicine: medicines[index],
//                                   );
//                                 },
//                               );
//                             }
//
//                             return const SizedBox.shrink();
//                           },
//                         ),
//
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _InfoCard extends StatelessWidget {
//   const _InfoCard({
//     required this.icon,
//     required this.title,
//     required this.value,
//   });
//
//   final IconData icon;
//   final String title;
//   final String value;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: colorScheme.outline),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: colorScheme.primary),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colorScheme.onSurfaceVariant,
//                     fontSize: 13,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MedicineCard extends StatelessWidget {
//   const _MedicineCard({required this.medicine});
//
//   final MedicineEntity medicine;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     final expiry = medicine.expiryDate;
//     final expiryText = expiry != null
//         ? '${_monthName(expiry.month)} ${expiry.year}'
//         : '-';
//
//     final isExpired = medicine.isExpired;
//     final hasExpiryInfo = expiry != null;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           // بوردر أحمر خفيف لو الدواء منتهي، عشان يبان من أول نظرة
//           color: isExpired
//               ? Colors.red.withValues(alpha: 0.4)
//               : colorScheme.outline,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _MedicineImage(imageUrl: medicine.imageUrl, colorScheme: colorScheme),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         medicine.name,
//                         style: theme.textTheme.bodyLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     if (hasExpiryInfo) ...[
//                       const SizedBox(width: 8),
//                       _ExpiryBadge(isExpired: isExpired),
//                     ],
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'Qty: ${medicine.quantity}',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colorScheme.onSurfaceVariant,
//                     fontSize: 13,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   'Expiry: $expiryText',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: isExpired
//                         ? Colors.red
//                         : colorScheme.onSurfaceVariant,
//                     fontSize: 13,
//                     fontWeight: isExpired ? FontWeight.w600 : null,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
//         ],
//       ),
//     );
//   }
//
//   String _monthName(int month) {
//     const names = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     return names[month - 1];
//   }
// }
//
// /// صورة الدواء — لو مفيش imageUrl أو الرابط فشل، بيعرض أيقونة بديلة
// class _MedicineImage extends StatelessWidget {
//   const _MedicineImage({
//     required this.imageUrl,
//     required this.colorScheme,
//   });
//
//   final String? imageUrl;
//   final ColorScheme colorScheme;
//
//   @override
//   Widget build(BuildContext context) {
//     final url = imageUrl;
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 56,
//         height: 56,
//         color: colorScheme.primary.withValues(alpha: 0.1),
//         child: url != null && url.isNotEmpty
//             ? Image.network(
//           url,
//           fit: BoxFit.cover,
//           loadingBuilder: (context, child, progress) {
//             if (progress == null) return child;
//             return Center(
//               child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: colorScheme.primary,
//                 ),
//               ),
//             );
//           },
//           errorBuilder: (context, error, stackTrace) => Icon(
//             Icons.medication_outlined,
//             color: colorScheme.primary,
//           ),
//         )
//             : Icon(Icons.medication_outlined, color: colorScheme.primary),
//       ),
//     );
//   }
// }
//
// /// شارة صغيرة توضح إن الدواء لسه صالح ولا منتهي
// class _ExpiryBadge extends StatelessWidget {
//   const _ExpiryBadge({required this.isExpired});
//
//   final bool isExpired;
//
//   @override
//   Widget build(BuildContext context) {
//     final color = isExpired ? Colors.red : Colors.green;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         isExpired ? 'Expired' : 'Valid',
//         style: TextStyle(
//           color: color,
//           fontSize: 11,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/household_member_entity.dart';
import '../../../domain/entity/medicine_entity.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({
    super.key,
    required this.member,
    required this.householdId,
  });

  final HouseholdMemberEntity member;
  final String householdId;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) =>
      getIt<HouseholdCubit>()
        ..getMemberMedicines(householdId: householdId, userId: member.id),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.householdMemberDetails,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        _MemberAvatar(
                          name: member.name,
                          photoUrl: member.photoUrl,
                          radius: 48,
                          colorScheme: colorScheme,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          member.name.isNotEmpty ? member.name : 'Unnamed',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '${member.medicineCount} ${l10n.medicines}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.memberInformation,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        _InfoCard(
                          icon: Icons.person_outline,
                          title: l10n.name,
                          value: member.name,
                        ),

                        const SizedBox(height: 12),

                        _InfoCard(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: member.email,
                        ),

                        const SizedBox(height: 12),

                        _InfoCard(
                          icon: Icons.medication_outlined,
                          title: l10n.medicines,
                          value: '${member.medicineCount}',
                        ),

                        const SizedBox(height: 30),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.memberMedicines,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        BlocBuilder<HouseholdCubit, HouseholdState>(
                          builder: (context, state) {
                            if (state is GetMemberMedicinesLoading) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state is GetMemberMedicinesError) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24,
                                ),
                                child: Center(
                                  child: Text(
                                    state.message,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }

                            if (state is GetMemberMedicinesSuccess) {
                              final medicines = state.medicines;

                              if (medicines.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No medicines found',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: medicines.length,
                                separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  return _MedicineCard(
                                    medicine: medicines[index],
                                  );
                                },
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({required this.medicine});

  final MedicineEntity medicine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final expiry = medicine.expiryDate;
    final expiryText = expiry != null
        ? '${_monthName(expiry.month)} ${expiry.year}'
        : '-';

    final isExpired = medicine.isExpired;
    final hasExpiryInfo = expiry != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // بوردر أحمر خفيف لو الدواء منتهي، عشان يبان من أول نظرة
          color: isExpired
              ? Colors.red.withValues(alpha: 0.4)
              : colorScheme.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MedicineImage(imageUrl: medicine.imageUrl, colorScheme: colorScheme),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        medicine.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (hasExpiryInfo) ...[
                      const SizedBox(width: 8),
                      _ExpiryBadge(isExpired: isExpired),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Qty: ${medicine.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Expiry: $expiryText',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isExpired
                        ? Colors.red
                        : colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    fontWeight: isExpired ? FontWeight.w600 : null,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = [
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
    return names[month - 1];
  }
}

/// صورة الدواء — لو مفيش imageUrl أو الرابط فشل، بيعرض أيقونة بديلة
class _MedicineImage extends StatelessWidget {
  const _MedicineImage({
    required this.imageUrl,
    required this.colorScheme,
  });

  final String? imageUrl;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        color: colorScheme.primary.withValues(alpha: 0.1),
        child: url != null && url.isNotEmpty
            ? Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.medication_outlined,
            color: colorScheme.primary,
          ),
        )
            : Icon(Icons.medication_outlined, color: colorScheme.primary),
      ),
    );
  }
}

/// شارة صغيرة توضح إن الدواء لسه صالح ولا منتهي
class _ExpiryBadge extends StatelessWidget {
  const _ExpiryBadge({required this.isExpired});

  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    final color = isExpired ? Colors.red : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isExpired ? 'Expired' : 'Valid',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// أفاتار الشخص: بيعرض الصورة الحقيقية لو موجودة، ولو مفيش أو فشل التحميل
/// يرجع للحرف الأول من الاسم كـ fallback
class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({
    required this.name,
    required this.photoUrl,
    required this.radius,
    required this.colorScheme,
  });

  final String name;
  final String? photoUrl;
  final double radius;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;

    if (!hasPhoto) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: colorScheme.primary,
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.7,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ClipOval(
      child: Image.network(
        photoUrl!,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return CircleAvatar(
            radius: radius,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            child: SizedBox(
              width: radius * 0.7,
              height: radius * 0.7,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => CircleAvatar(
          radius: radius,
          backgroundColor: colorScheme.primary,
          child: Text(
            initial,
            style: TextStyle(
              color: Colors.white,
              fontSize: radius * 0.7,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}