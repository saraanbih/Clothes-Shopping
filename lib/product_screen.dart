import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedSize = 1;
  int selectedColor = 0;
  int quantity = 1;

  final sizes = ["XS", "S", "M", "L", "XL"];
  final colors = [Colors.red, Colors.blueGrey, Colors.green, Colors.black];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD2A88F),
                    image: DecorationImage(
                      image: AssetImage(widget.product['image']),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black26,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  left: 20,
                  child: _circleButton(
                    Icons.arrow_back,
                    () => Navigator.popUntil(context, (route) => route.isFirst),
                  ),
                ),

                Positioned(
                  top: 50,
                  right: 20,
                  child: _circleButton(Icons.favorite_border, () {}),
                ),

                const Center(
                  child: Icon(Icons.checkroom, size: 120, color: Colors.blue),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product['name'] ?? 'Product',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product['price'] ?? '',
                        style: const TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "⭐⭐⭐⭐⭐ (128 reviews)",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.product['description'] ??
                        'A light and breathable floral dress perfect for warm days.',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Select Size",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: List.generate(sizes.length, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedSize = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedSize == index
                                ? Colors.black
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            sizes[index],
                            style: TextStyle(
                              color: selectedSize == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Color",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: List.generate(colors.length, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: selectedColor == index
                                ? Border.all(width: 2, color: Colors.black)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: colors[index],
                          ),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text("$quantity"),
                            IconButton(
                              onPressed: () {
                                setState(() => quantity++);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Add to Cart"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(onPressed: onTap, icon: Icon(icon)),
    );
  }
}
