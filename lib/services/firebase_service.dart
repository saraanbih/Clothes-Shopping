import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_profile.dart';

class FirebaseService {
  static bool _initialized = false;
  static bool _available = true;

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static bool get isAvailable => _available;

  static CollectionReference get productsRef => firestore.collection('products');

  static DocumentReference userDoc(String uid) => firestore.collection('users').doc(uid);
  static CollectionReference cartRef(String uid) => userDoc(uid).collection('cart');
  static CollectionReference wishlistRef(String uid) => userDoc(uid).collection('wishlist');
  static CollectionReference ordersRef(String uid) => userDoc(uid).collection('orders');

  /// Initialize Firebase - handles errors gracefully for platforms without Firebase support
  static Future<void> init() async {
    if (_initialized) return;
    try {
      await Firebase.initializeApp();
      _available = true;
    } catch (e) {
      // Firebase not available on this platform (e.g., Linux desktop)
      // App will run in offline mode with sample data
      // Silently fail and continue in offline mode
      _available = false;
    } finally {
      _initialized = true;
    }
  }

  static Stream<User?> get authStateChanges => auth.authStateChanges();

  static Future<UserCredential> signIn(String email, String password) {
    if (!_available) {
      throw FirebaseAuthException(
        code: 'firebase-unavailable',
        message: 'Firebase is not available on this platform.',
      );
    }
    return auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  static Future<UserCredential> registerUser(String displayName, String email, String password) async {
    if (!_available) {
      throw FirebaseAuthException(
        code: 'firebase-unavailable',
        message: 'Firebase is not available on this platform.',
      );
    }
    final credential = await auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
    final user = credential.user;
    if (user != null) {
      await user.updateDisplayName(displayName.trim());
      await user.reload();
      await userDoc(user.uid).set({
        'displayName': displayName.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return credential;
  }

  static Future<void> resetPassword(String email) {
    if (!_available) {
      throw FirebaseAuthException(
        code: 'firebase-unavailable',
        message: 'Firebase is not available on this platform.',
      );
    }
    return auth.sendPasswordResetEmail(email: email.trim());
  }

  static Future<void> signOut() {
    if (!_available) return Future.value();
    return auth.signOut();
  }

  static Future<UserProfile?> getProfile(String uid) async {
    final snapshot = await userDoc(uid).get();
    if (!snapshot.exists) return null;
    return UserProfile.fromMap(uid, snapshot.data() as Map<String, dynamic>);
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    await userDoc(profile.uid).set(profile.toJson(), SetOptions(merge: true));
  }

  static Future<List<ProductModel>> seedProducts() async {
    final query = await productsRef.limit(1).get();
    if (query.docs.isNotEmpty) {
      return query.docs.map(ProductModel.fromFirestore).toList();
    }

    final products = ProductModel.sampleProducts();
    final batch = firestore.batch();
    for (final product in products) {
      final ref = productsRef.doc(product.id);
      batch.set(ref, product.toJson());
    }
    await batch.commit();
    return products;
  }

  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final snapshot = await productsRef.get();
      if (snapshot.docs.isEmpty) {
        return await seedProducts();
      }
      return snapshot.docs.map(ProductModel.fromFirestore).toList();
    } on FirebaseException {
      return ProductModel.sampleProducts();
    } catch (e) {
      return ProductModel.sampleProducts();
    }
  }

  static Future<List<CartItemModel>> fetchCartItems(String uid) async {
    final snapshot = await cartRef(uid).get();
    return snapshot.docs.map(CartItemModel.fromFirestore).toList();
  }

  static Future<void> addOrUpdateCartItem(String uid, CartItemModel item) async {
    final ref = cartRef(uid).doc(item.product.id);
    await ref.set(item.toJson(), SetOptions(merge: true));
  }

  static Future<void> removeCartItem(String uid, String itemId) async {
    await cartRef(uid).doc(itemId).delete();
  }

  static Future<void> clearCart(String uid) async {
    final snapshot = await cartRef(uid).get();
    final batch = firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  static Future<List<ProductModel>> fetchWishlist(String uid) async {
    final snapshot = await wishlistRef(uid).get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  static Future<void> toggleWishlistItem(String uid, ProductModel product, bool exists) async {
    final ref = wishlistRef(uid).doc(product.id);
    if (exists) {
      await ref.delete();
    } else {
      await ref.set(product.toJson());
    }
  }

  static Future<List<OrderModel>> fetchOrders(String uid) async {
    final snapshot = await ordersRef(uid).orderBy('createdAt', descending: true).get();
    return snapshot.docs.map(OrderModel.fromFirestore).toList();
  }

  static Future<void> placeOrder(String uid, List<CartItemModel> items, String shippingAddress) async {
    final total = items.fold<double>(0, (previousValue, item) => previousValue + item.totalPrice);
    final orderRef = ordersRef(uid).doc();
    await orderRef.set({
      'items': items
          .map((item) => {
                'product': {
                  'id': item.product.id,
                  'name': item.product.name,
                  'category': item.product.category,
                  'description': item.product.description,
                  'imageUrl': item.product.imageUrl,
                  'price': item.product.price,
                  'tag': item.product.tag,
                  'rating': item.product.rating,
                  'isNew': item.product.isNew,
                },
                'quantity': item.quantity,
                'size': item.size,
                'color': item.color,
              })
          .toList(),
      'total': total,
      'status': 'Confirmed',
      'shippingAddress': shippingAddress,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await clearCart(uid);
  }

  static Future<UserCredential> signInWithGoogle() async {
    if (!_available) {
      throw FirebaseAuthException(
        code: 'firebase-unavailable',
        message: 'Firebase is not available on this platform.',
      );
    }
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(message: 'Google sign in aborted.', code: 'ERROR_ABORTED_BY_USER');
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user != null) {
      await userDoc(user.uid).set({
        'displayName': user.displayName ?? 'Guest',
        'email': user.email ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
    return userCredential;
  }
}
