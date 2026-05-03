import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'orderconfirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutScreen> {
  String _paymentMethod = 'card';

  final _nameController       = TextEditingController();
  final _streetController     = TextEditingController();
  final _cityController       = TextEditingController();
  final _zipController        = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _mmyyController       = TextEditingController();
  final _cvvController        = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _cardNumberController.dispose();
    _mmyyController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0EB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xFF1A1A1A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: Column(
          children: [
            // ─── Delivery Address ───
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    icon: Icons.location_on,
                    iconColor: const Color(0xFFE8553E),
                    label: 'Delivery Address',
                  ),
                  const SizedBox(height: 14),
                  _buildField(
                    controller: _nameController,
                    hint: 'Full Name',
                  ),
                  const SizedBox(height: 10),
                  _buildField(
                    controller: _streetController,
                    hint: 'Street Address',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          controller: _cityController,
                          hint: 'City',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildField(
                          controller: _zipController,
                          hint: 'ZIP',
                          inputType: TextInputType.number,
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ─── Payment ───
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    icon: Icons.credit_card,
                    iconColor: const Color(0xFF5B8DEF),
                    label: 'Payment',
                  ),
                  const SizedBox(height: 14),

                  // Toggle Card / Cash
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEE9E3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _toggleBtn('Card', 'card'),
                        _toggleBtn('Cash', 'cash'),
                      ],
                    ),
                  ),

                  if (_paymentMethod == 'card') ...[
                    const SizedBox(height: 10),
                    _buildField(
                      controller: _cardNumberController,
                      hint: 'Card Number',
                      inputType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _mmyyController,
                            hint: 'MM/YY',
                            inputType: TextInputType.number,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildField(
                            controller: _cvvController,
                            hint: 'CVV',
                            obscure: true,
                            inputType: TextInputType.number,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─── Total ───
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  '\$109.00',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE8553E),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ─── Place Order ───
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8553E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Place Order 🛍️',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── helpers ────────────────────────────────────────────

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withBlue(1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? formatters,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscure,
      inputFormatters: formatters,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFB0A99F)),
        filled: true,
        fillColor: const Color(0xFFF5F0EB),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFE8553E), width: 1.5),
        ),
      ),
    );
  }

  Widget _toggleBtn(String label, String value) {
    final bool selected = _paymentMethod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _paymentMethod = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1A1A1A) : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : const Color(0xFF888888),
            ),
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OrderConfirmationScreen(),
      ),
    );
  }
}