import 'package:flutter/material.dart';

// ─── Wishlist Item Model ───────────────────────────────────
class WishlistItem {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final String imagePlaceholder;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.imagePlaceholder,
  });
}

// ─── Sample Data ──────────────────────────────────────────
final List<WishlistItem> wishlistItems = [
  WishlistItem(
    id: '1',
    name: 'Floral Summer Dress',
    category: 'Women',
    subcategory: 'Dress',
    price: 49,
    imagePlaceholder: 'assets/images/20.jpg',
  ),
  WishlistItem(
    id: '2',
    name: 'dior bag',
    category: 'bags',
    subcategory: 'bags',
    price: 89,
    imagePlaceholder: 'assets/images/image2.png', 
  ),
  WishlistItem(
    id: '3',
    name: 'heels',
    category: 'hells',
    subcategory: 'Top',
    price: 18,
    imagePlaceholder: 'assets/images/image3.jpg',
  ),
];

// ─── Wishlist Screen ──────────────────────────────────────
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<WishlistItem> _items = List.from(wishlistItems);

  void _addToCart(WishlistItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart!'),
        backgroundColor: const Color(0xFFE8553E),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF7F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xFF1A1A1A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'My Wishlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.favorite_border,
                color: Color(0xFF1A1A1A), size: 18),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          ..._items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _WishlistCard(
                  item: item,
                  onAddToCart: () => _addToCart(item),
                ),
              )),
          _BrowseMoreCard(
            onBrowse: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ─── Wishlist Card ────────────────────────────────────────
class _WishlistCard extends StatelessWidget {
  final WishlistItem item;
  final VoidCallback onAddToCart;

  const _WishlistCard({
    required this.item,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withBlue(1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImage(item),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.category} · ${item.subcategory}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE8553E),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onAddToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8553E),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(WishlistItem item) {
    return Image.asset(
      item.imagePlaceholder,
      width: 70,
      height: 70,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 70,
          height: 70,
          color: const Color(0xFFF0EBE6),
          child: const Icon(
            Icons.image_outlined,
            color: Color(0xFFCCBBAA),
            size: 30,
          ),
        );
      },
    );
  }
}

// ─── Browse More Card ─────────────────────────────────────
class _BrowseMoreCard extends StatelessWidget {
  final VoidCallback onBrowse;

  const _BrowseMoreCard({required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8E0D8),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F0EB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.add, color: Color(0xFF888888), size: 22),
          ),
          const SizedBox(height: 10),
          const Text(
            'Keep browsing to save more',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onBrowse,
            child: const Text(
              'Browse Collection →',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE8553E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
