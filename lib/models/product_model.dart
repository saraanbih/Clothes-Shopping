import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  final String tag;
  final double rating;
  final bool isNew;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.tag = '',
    this.rating = 4.5,
    this.isNew = false,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ProductModel(
      id: doc.id,
      name: data['name'] as String? ?? 'Unknown',
      category: data['category'] as String? ?? 'All',
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      tag: data['tag'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
      isNew: data['isNew'] as bool? ?? false,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> data, {String? id}) {
    return ProductModel(
      id: id ?? data['id'] as String? ?? '',
      name: data['name'] as String? ?? 'Unknown',
      category: data['category'] as String? ?? 'All',
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      tag: data['tag'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
      isNew: data['isNew'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'tag': tag,
      'rating': rating,
      'isNew': isNew,
    };
  }

  static List<ProductModel> sampleProducts() {
    return [
      ProductModel(
        id: 'floral_summer_dress',
        name: 'Floral Summer Dress',
        category: 'Women',
        description:
            'A breathable floral dress perfect for warm days and relaxed outings.',
        imageUrl: 'assets/home_screen_images/floral_summer_dress.jpg',
        price: 49.0,
        tag: 'NEW',
        rating: 4.8,
        isNew: true,
      ),
      ProductModel(
        id: 'classic_white_tee',
        name: 'Classic White Tee',
        category: 'Men',
        description:
            'A classic tee made of soft cotton with a clean modern fit.',
        imageUrl: 'assets/home_screen_images/classic_white_tee.jpg',
        price: 24.0,
        rating: 4.3,
      ),
      ProductModel(
        id: 'wide_linen_pants',
        name: 'Wide Linen Pants',
        category: 'Women',
        description:
            'Light linen pants that are easy to wear from day to night.',
        imageUrl: 'assets/home_screen_images/wide_linen_pants.jpg',
        price: 58.0,
        tag: '-15%',
        rating: 4.4,
      ),
      ProductModel(
        id: 'denim_jacket',
        name: 'Denim Jacket',
        category: 'Men',
        description:
            'A timeless denim jacket with a relaxed fit and polished finish.',
        imageUrl: 'assets/home_screen_images/denim_jacket.jpg',
        price: 89.0,
        tag: 'HOT',
        rating: 4.6,
      ),
      ProductModel(
        id: 'kids_dino_tee',
        name: 'Kids Dino Tee',
        category: 'Kids',
        description: 'A playful dinosaur tee for kids with a vibrant print.',
        imageUrl: 'assets/home_screen_images/kids_dino_tee.jpg',
        price: 18.0,
        rating: 4.2,
      ),
      ProductModel(
        id: 'knit_blouse',
        name: 'Knit Blouse',
        category: 'Women',
        description:
            'A stylish knit blouse crafted for comfort and effortless warmth.',
        imageUrl: 'assets/home_screen_images/knit_blouse.jpg',
        price: 36.0,
        tag: 'NEW',
        rating: 4.5,
        isNew: true,
      ),
    ];
  }
}
