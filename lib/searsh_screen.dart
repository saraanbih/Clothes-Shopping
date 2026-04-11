import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "women Collection",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.grid_view, color: Colors.black),
          ),
        ],
      ),

      body: Column(
        children: [
          //  Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          //  Categories
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryChip(text: "All", selected: true),
                CategoryChip(text: "Dresses"),
                CategoryChip(text: "Tops"),
                CategoryChip(text: "Hells"),
                CategoryChip(text: "Jackets"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Products
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),

      //  Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String text;
  final bool selected;

  const CategoryChip({super.key, required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(text),
        backgroundColor: selected ? Colors.black : Colors.grey[200],
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
      ),
    );
  }
}

// Product Model
class Product {
  final String name;
  final double price;
  final String image;
  bool isFavorite;

  final double rating;
  final bool isNew;

  Product({
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
    this.rating = 4.5,
    this.isNew = false,
  });
}

// Data
List<Product> products = [
  Product(
    name: "Floral Dress",
    price: 49,
    image: "assets/search_iscreen_mage/20.jpg",
    rating: 4.8,
    isNew: true,
  ),
  Product(
    name: "dior bag",
    price: 24,
    image: "assets/search_iscreen_mage/image2.jpg",
    rating: 4.8,
    isNew: false,
  ),
  Product(
    name: "silver heels",
    price: 30,
    image: "assets/search_iscreen_mage/image3.jpg",
    rating: 4.8,
    isNew: false,
  ),
  Product(
    name: "Floral Dress",
    price: 49,
    image: "assets/search_iscreen_mage/20.jpg",
    rating: 4.8,
    isNew: true,
  ),
  Product(
    name: "modern blouse",
    price: 36,
    image: "assets/search_iscreen_mage/image4.jpg",
    rating: 4.8,
    isNew: false,
  ),
  Product(
    name: "skyblue blouse",
    price: 35,
    image: "assets/search_iscreen_mage/image5.jpg",
    rating: 4.8,
    isNew: true,
  ),
];

//Product Card
class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Favorite
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 206, 57, 11),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < product.rating.floor() ? Icons.star : Icons.star_border,
                size: 14,
                color: Colors.amber,
              );
            }),
          ),

          const SizedBox(height: 4),

          Text(
            "\$${product.price}",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
