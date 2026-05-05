import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orderconfirmation_screen.dart';
import 'providers/shop_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();
    final cartItems = provider.cartItems;
    final total = cartItems.fold<double>(
      0,
      (previousValue, item) => previousValue + item.totalPrice,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('My Cart', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              for (final item in cartItems) {
                provider.removeCartItem(item.id);
              }
            },
            child: const Text('Clear', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(item: cartItems[index]);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _row('Subtotal', '\$${total.toStringAsFixed(0)}'),
                _row('Shipping', 'Free'),
                _row('Discount', '- \$0'),
                const Divider(),
                _row('Total', '\$${total.toStringAsFixed(0)}', isBold: true),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 230, 62, 20),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: cartItems.isEmpty
                      ? null
                      : () async {
                          await provider.placeOrder(
                            '123 Main Street, Cairo, Egypt',
                          );
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OrderConfirmationScreen(),
                              ),
                            );
                          }
                        },
                  child: const Text('Proceed to Checkout →'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Continue Shopping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold
                  ? const Color.fromARGB(255, 230, 62, 20)
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final dynamic item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ShopProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(item.product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 6),
                Text(
                  'Size: ${item.size} • ${item.color}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _btn('-', () {
                final nextQuantity = item.quantity - 1;
                if (nextQuantity <= 0) {
                  provider.removeCartItem(item.id);
                } else {
                  provider.updateCartQuantity(item.id, nextQuantity);
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(item.quantity.toString()),
              ),
              _btn('+', () {
                provider.updateCartQuantity(item.id, item.quantity + 1);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btn(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
