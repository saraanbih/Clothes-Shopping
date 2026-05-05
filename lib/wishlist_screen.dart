import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product_model.dart';
import 'providers/shop_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();
    final wishlist = provider.wishlist;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF7F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1A1A1A),
            size: 18,
          ),
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
            Icon(Icons.favorite_border, color: Color(0xFF1A1A1A), size: 18),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          if (wishlist.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  'Your wishlist is empty.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ...wishlist.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _WishlistCard(item: item),
            ),
          ),
          _BrowseMoreCard(onBrowse: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final ProductModel item;

  const _WishlistCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ShopProvider>();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.imageUrl,
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
            ),
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
                  item.category,
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
          IconButton(
            onPressed: () {
              provider.toggleWishlist(item);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Removed from wishlist')),
              );
            },
            icon: const Icon(Icons.favorite, color: Color(0xFFE8553E)),
            tooltip: 'Remove from wishlist',
          ),
          ElevatedButton(
            onPressed: () {
              provider.addToCart(item);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8553E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
}

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
        border: Border.all(color: const Color(0xFFE8E0D8), width: 1),
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
          const SizedBox(height: 12),
          const Text(
            'Browse more styles',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Explore our collection and save your favorite looks.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF999999)),
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onBrowse, child: const Text('Browse Now')),
        ],
      ),
    );
  }
}
