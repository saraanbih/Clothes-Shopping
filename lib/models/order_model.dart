import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item_model.dart';
import 'product_model.dart';

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final double total;
  final String status;
  final String shippingAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final products = (data['items'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final items = products.map((item) {
      final productSnapshot = Map<String, dynamic>.from(
        item['product'] as Map? ?? {},
      );
      final product = ProductModel.fromMap(
        productSnapshot,
        id: productSnapshot['id'] as String?,
      );

      return CartItemModel(
        id: item['product']['id'] as String? ?? '',
        product: product,
        quantity: (item['quantity'] as num?)?.toInt() ?? 1,
        size: item['size'] as String? ?? 'M',
        color: item['color'] as String? ?? 'Black',
      );
    }).toList();

    return OrderModel(
      id: doc.id,
      items: items,
      total: (data['total'] as num?)?.toDouble() ?? 0,
      status: data['status'] as String? ?? 'Processing',
      shippingAddress: data['shippingAddress'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items
          .map(
            (item) => {
              'product': item.product.toJson()..['id'] = item.product.id,
              'quantity': item.quantity,
              'size': item.size,
              'color': item.color,
            },
          )
          .toList(),
      'total': total,
      'status': status,
      'shippingAddress': shippingAddress,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
