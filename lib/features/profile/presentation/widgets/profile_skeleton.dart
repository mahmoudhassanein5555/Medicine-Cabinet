import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark
        ? Colors.grey.shade800
        : Colors.grey.shade300;

    final highlightColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade100;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              // =========================
              // Profile Header
              // =========================

              _buildProfileHeader(),

              const SizedBox(height: 24),

              // =========================
              // Account
              // =========================

              _buildSection(
                children: [
                  _buildOptionTile(),
                  _buildOptionTile(),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // Reminders
              // =========================

              _buildSection(
                children: [
                  _buildOptionTile(),
                  _buildOptionTile(),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // App
              // =========================

              _buildSection(
                children: [
                  _buildOptionTile(),
                  _buildOptionTile(),
                  _buildSwitchTile(),
                  _buildLanguageTile(),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // Information
              // =========================

              _buildSection(
                children: [
                  _buildOptionTile(),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // Logout
              // =========================

              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Profile Header
  // =====================================================

  Widget _buildProfileHeader() {
    return Row(
      children: [
        // Same size as ProfileHeader CircleAvatar
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Container(
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 4),

              // Email
              Container(
                width: 190,
                height: 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Section
  // =====================================================

  Widget _buildSection({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // =====================================================
  // Normal ProfileOptionTile
  // =====================================================

  Widget _buildOptionTile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const Spacer(),

              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),

        const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }

  // =====================================================
  // Switch Tile
  // =====================================================

  Widget _buildSwitchTile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const Spacer(),

              Container(
                width: 45,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),

        const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }

  // =====================================================
  // Language Tile
  // =====================================================

  Widget _buildLanguageTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const Spacer(),

          Container(
            width: 70,
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}