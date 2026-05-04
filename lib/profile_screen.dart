import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color navy = Color(0xFF1A1A2E);
  static const Color red = Color(0xFFC8553D);
  static const Color cream = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFF0EBE3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    label: 'My Orders',
                    onTap: () {
                      // TODO: navigate to Orders screen
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    label: 'Saved Addresses',
                    onTap: () {
                      // TODO: navigate to Addresses screen
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    label: 'My Wishlist',
                    onTap: () {
                      // TODO: navigate to Wishlist screen
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.credit_card_outlined,
                    label: 'Payment Methods',
                    onTap: () {
                      // TODO: navigate to Payment screen
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {
                      // TODO: navigate to Notifications screen
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () {},
                  ),

                  const SizedBox(height: 10),

                  _buildMenuItem(
                    icon: Icons.logout,
                    label: 'Sign Out',
                    iconColor: red,
                    labelColor: red,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [navy, red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // Only round the bottom corners
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Name and email
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rahma Hosam',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rahma@email.com',
                        style: TextStyle(fontSize: 13, color: Colors.white60),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Stats row: Orders / Wishlist / Reviews ──
              // A thin divider separates each stat.
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Orders stat
                    _StatItem(number: '12', label: 'Orders'),

                    // Vertical divider
                    SizedBox(
                      height: 36,
                      child: VerticalDivider(color: Colors.white24, width: 1),
                    ),

                    // Wishlist stat
                    _StatItem(number: '5', label: 'Wishlist'),

                    // Vertical divider
                    SizedBox(
                      height: 36,
                      child: VerticalDivider(color: Colors.white24, width: 1),
                    ),

                    // Reviews stat
                    _StatItem(number: '3', label: 'Reviews'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = navy, // default icon color
    Color labelColor = navy, // default text color
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon inside a small rounded box
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),

            const SizedBox(width: 14),

            // Menu label — takes all remaining space
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
              ),
            ),

            // Arrow on the right side
            Icon(Icons.chevron_right, color: Colors.grey[300], size: 22),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
      ],
    );
  }
}
