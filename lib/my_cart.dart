import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(
              child: Text("Clear", style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                CartItem(
                  name: "Floral Dress",
                  price: 49,
                  color: Colors.red,
                  images: "assets/search_iscreen_mage/20.jpg",
                ),
                CartItem(
                  name: "Dior Bag",
                  price: 24,
                  color: Colors.blue,
                  images: "assets/search_iscreen_mage/image2.jpg",
                ),
                CartItem(
                  name: "modern Blouse",
                  price: 36,
                  color: Colors.purple,
                  images: "assets/search_iscreen_mage/image4.jpg",
                ),
              ],
            ),
          ),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _row("Subtotal", "\$133"),
                _row("Shipping", "Free"),
                _row("Discount", "- \$24"),
                const Divider(),
                _row("Total", "\$109", isBold: true),

                const SizedBox(height: 15),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 230, 62, 20),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Proceed to Checkout →"),
                ),

                const SizedBox(height: 10),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Continue Shopping"),
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

//  Cart Item
class CartItem extends StatefulWidget {
  final String name;
  final double price;
  final Color color;
  final String images;

  const CartItem({
    super.key,
    required this.name,
    required this.price,
    required this.color,
    required this.images,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.images, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                const SizedBox(height: 4),
                Text(
                  "\$${widget.price}",
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),

          Row(
            children: [
              _btn("-", () {
                if (quantity > 1) {
                  setState(() => quantity--);
                }
              }),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(quantity.toString()),
              ),

              _btn("+", () {
                setState(() => quantity++);
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
