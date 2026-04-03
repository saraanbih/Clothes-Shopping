import 'package:flutter/material.dart';
import 'searsh_screen.dart';
import 'my_cart.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color navy = Color(0xFF1A1A2E);
  static const Color red = Color(0xFFC8553D);
  static const Color cream = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFF0EBE3);

  int _selectedTab = 0;

  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _categories = [
    {'label': 'All', 'icon': Icons.grid_view_rounded},
    {'label': 'Women', 'icon': Icons.woman},
    {'label': 'Men', 'icon': Icons.man},
    {'label': 'Kids', 'icon': Icons.child_care},
    {'label': 'Shoes', 'icon': Icons.roller_skating_outlined},
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Floral Summer Dress',
      'category': 'Women',
      'price': '\$49',
      'tag': 'NEW',
      'image': 'assets/home_screen_images/floral_summer_dress.jpg',
    },
    {
      'name': 'Classic White Tee',
      'category': 'Men',
      'price': '\$24',
      'tag': '',
      'image': 'assets/home_screen_images/classic_white_tee.jpg',
    },
    {
      'name': 'Wide Linen Pants',
      'category': 'Women',
      'price': '\$58',
      'tag': '-15%',
      'image': 'assets/home_screen_images/linen_wide_pants.jpg',
    },
    {
      'name': 'Denim Jacket',
      'category': 'Men',
      'price': '\$89',
      'tag': 'HOT',
      'image': 'assets/home_screen_images/denim_jacket.jpg',
    },
    {
      'name': 'Kids Dino Tee',
      'category': 'Kids',
      'price': '\$18',
      'tag': '',
      'image': 'assets/home_screen_images/kids_dino_tee.jpg',
    },
    {
      'name': 'Knit Blouse',
      'category': 'Women',
      'price': '\$36',
      'tag': 'NEW',
      'image': 'assets/home_screen_images/knit_blouse.jpg',
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == 'All') return _products;
    return _products.where((p) => p['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            _buildTopBar(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroBanner(),
                    _buildSectionTitle('Shop by Category'),
                    _buildCategoryChips(),
                    _buildSectionTitle('Featured Items'),
                    _buildProductGrid(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  //  TOP BAR

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello', style: TextStyle(fontSize: 13, color: Colors.grey)),
              Text(
                'DRAPE',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: navy,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          Row(
            children: [
              _iconButton(
                Icons.search,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductsPage(),
                    ),
                  );
                },
              ),

              const SizedBox(width: 8),

              // Cart button with a red badge showing item count
              Stack(
                children: [
                  _iconButton(
                    Icons.shopping_bag_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //  HERO BANNER

  Widget _buildHeroBanner() {
    return GestureDetector(
      onTap: () {
        // TODO: navigate to the Sale / Listing screen
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        height: 160,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [navy, red],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left: text content
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Arrivals',
                    style: TextStyle(fontSize: 13, color: Colors.white60),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Summer Sale\nUp to 40% Off',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text(
                        'Shop Now →',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right: decorative icon
            const Icon(Icons.checkroom, size: 80, color: Colors.white12),
          ],
        ),
      ),
    );
  }

  //  SECTION TITLE

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: navy,
        ),
      ),
    );
  }

  //  CATEGORY CHIPS

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _categories.map((cat) {
          final bool isSelected = _selectedCategory == cat['label'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = cat['label'];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? navy : surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    cat['icon'],
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //  PRODUCT GRID  (2 columns)

  Widget _buildProductGrid() {
    final products = _filteredProducts;

    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Text(
            'No items in this category yet.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 12, // gap between columns
          mainAxisSpacing: 12, // gap between rows
          childAspectRatio: 0.72, // card height vs width ratio
        ),

        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  //  SINGLE PRODUCT CARD

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: surface,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: 36,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: add to wishlist
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  // Tag Badge e.g. NEW / HOT / -15% (top-left corner)
                  // The 'if' means this only appears when the tag is not empty
                  if (product['tag'] != '')
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product['tag'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Product Name and Price
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: navy,
                    ),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // "..." if name is too long
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  BOTTOM NAVIGATION BAR

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: (index) {
        setState(() {
          _selectedTab = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductsPage(),
            ),
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: red,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  //  small square icon button

  Widget _iconButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: navy, size: 20),
      ),
    );
  }
}
