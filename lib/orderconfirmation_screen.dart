import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ─── Check icon circle ───
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8553E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 42),
              ),

              const SizedBox(height: 20),

              // ─── Title ───
              const Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 8),

              // ─── Subtitle ───
              const Text(
                'Thanks for shopping with us.\nYour order is being prepared.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888888),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // ─── Order details card ───
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withBlue(1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _detailRow('Order #', '#DRP-20481',
                        valueColor: const Color(0xFF1A1A1A)),
                    const SizedBox(height: 12),
                    _detailRow('Items', '3 items'),
                    const SizedBox(height: 12),
                    _detailRow('Total', '\$109.00',
                        valueColor: const Color(0xFFE8553E)),
                    const SizedBox(height: 12),
                    _detailRow('Estimated', '3–5 days'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ─── Progress stepper ───
              _buildStepper(),

              const SizedBox(height: 36),

              // ─── Back to Home button ───
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // يرجع للـ home ويمسح كل الـ stack
                    Navigator.of(context)
                        .popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8553E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ─── Track Order button ───
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color(0xFFE8553E), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Track Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE8553E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Order detail row ───
  Widget _detailRow(String label, String value,
      {Color valueColor = const Color(0xFF555555)}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF888888),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // ─── Progress stepper (Confirmed → Packed → Shipped → Delivered) ───
  Widget _buildStepper() {
    final steps = [
      {'icon': Icons.check_circle, 'done': true},
      {'icon': Icons.inventory_2_outlined, 'done': false},
      {'icon': Icons.local_shipping_outlined, 'done': false},
      {'icon': Icons.home_outlined, 'done': false},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          // connector line
          final bool prevDone = steps[index ~/ 2]['done'] as bool;
          return Expanded(
            child: Container(
              height: 2,
              color: prevDone
                  ? const Color(0xFFE8553E)
                  : const Color(0xFFE0DAD4),
            ),
          );
        }

        final step = steps[index ~/ 2];
        final bool done = step['done'] as bool;
        final IconData icon = step['icon'] as IconData;

        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color:
                done ? const Color(0xFFE8553E) : const Color(0xFFF0EBE6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 22,
            color: done ? Colors.white : const Color(0xFFBBB0A8),
          ),
        );
      }),
    );
  }
}