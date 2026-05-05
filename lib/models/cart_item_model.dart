import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final String size;
  final String color;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.size = 'M',
    this.color = 'Black',
  });

  double get totalPrice => product.price * quantity;

  factory CartItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final productSnapshot = Map<String, dynamic>.from(data['product'] as Map? ?? {});
    final product = ProductModel(
      id: productSnapshot['id'] as String? ?? doc.id,
      name: productSnapshot['name'] as String? ?? 'Unknown',
      category: productSnapshot['category'] as String? ?? 'All',
      description: productSnapshot['description'] as String? ?? '',
      imageUrl: productSnapshot['imageUrl'] as String? ?? '',
      price: (productSnapshot['price'] as num?)?.toDouble() ?? 0.0,
      tag: productSnapshot['tag'] as String? ?? '',
      rating: (productSnapshot['rating'] as num?)?.toDouble() ?? 4.5,
      isNew: productSnapshot['isNew'] as bool? ?? false,
    );

    return CartItemModel(
      id: doc.id,
      product: product,
      quantity: (data['quantity'] as num?)?.toInt() ?? 1,
      size: data['size'] as String? ?? 'M',
      color: data['color'] as String? ?? 'Black',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': {
        'id': product.id,
        'name': product.name,
        'category': product.category,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'tag': product.tag,
        'rating': product.rating,
        'isNew': product.isNew,
      },
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}
