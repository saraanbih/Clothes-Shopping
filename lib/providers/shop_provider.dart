import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_profile.dart';
import '../services/firebase_service.dart';

class ShopProvider extends ChangeNotifier {
  bool initializing = true;
  bool firebaseAvailable = true;
  String? errorMessage;

  User? currentUser;
  UserProfile? profile;
  List<ProductModel> products = [];
  List<CartItemModel> cartItems = [];
  List<ProductModel> wishlist = [];
  List<OrderModel> orders = [];

  ShopProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await FirebaseService.init();
      firebaseAvailable = FirebaseService.isAvailable;
      if (!firebaseAvailable) {
        errorMessage = 'Firebase is not available on this platform. Running in offline mode.';
      }
      FirebaseService.authStateChanges.listen((user) async {
        currentUser = user;
        if (user != null) {
          await _loadUserData();
        } else {
          profile = null;
          cartItems = [];
          wishlist = [];
          orders = [];
        }
        notifyListeners();
      });
      await loadProducts();
    } catch (error) {
      firebaseAvailable = false;
      errorMessage = 'Firebase initialization failed. Running in offline mode.';
      products = ProductModel.sampleProducts();
      notifyListeners();
    } finally {
      initializing = false;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    try {
      products = await FirebaseService.fetchProducts();
    } catch (error) {
      products = ProductModel.sampleProducts();
    }
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    if (currentUser == null) return;
    profile = await FirebaseService.getProfile(currentUser!.uid) ??
        UserProfile(
          uid: currentUser!.uid,
          displayName: currentUser!.displayName ?? 'Guest',
          email: currentUser!.email ?? '',
        );
    cartItems = await FirebaseService.fetchCartItems(currentUser!.uid);
    wishlist = await FirebaseService.fetchWishlist(currentUser!.uid);
    orders = await FirebaseService.fetchOrders(currentUser!.uid);
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseService.signIn(email, password);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Unable to sign in.';
    } catch (error) {
      return 'Unable to sign in at the moment.';
    }
  }

  Future<String?> register(String displayName, String email, String password) async {
    try {
      await FirebaseService.registerUser(displayName, email, password);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Unable to create account.';
    } catch (error) {
      return 'Unable to create account at the moment.';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await FirebaseService.resetPassword(email);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Unable to reset password.';
    } catch (error) {
      return 'Unable to reset password right now.';
    }
  }

  Future<void> signOut() async {
    await FirebaseService.signOut();
    currentUser = null;
    profile = null;
    cartItems = [];
    wishlist = [];
    orders = [];
    notifyListeners();
  }

  Future<void> addToCart(ProductModel product,
      {int quantity = 1, String size = 'M', String color = 'Black'}) async {
    if (currentUser == null) return;
    final existing = cartItems.where((item) => item.product.id == product.id).toList();
    final cartItem = CartItemModel(
      id: product.id,
      product: product,
      quantity: existing.isNotEmpty ? existing.first.quantity + quantity : quantity,
      size: size,
      color: color,
    );
    cartItems.removeWhere((item) => item.product.id == product.id);
    cartItems.add(cartItem);
    notifyListeners();
    await FirebaseService.addOrUpdateCartItem(currentUser!.uid, cartItem);
  }

  Future<void> updateCartQuantity(String itemId, int quantity) async {
    if (currentUser == null) return;
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index < 0) return;
    final item = cartItems[index];
    final updated = CartItemModel(
      id: item.id,
      product: item.product,
      quantity: quantity,
      size: item.size,
      color: item.color,
    );
    cartItems[index] = updated;
    notifyListeners();
    if (quantity <= 0) {
      await FirebaseService.removeCartItem(currentUser!.uid, itemId);
    } else {
      await FirebaseService.addOrUpdateCartItem(currentUser!.uid, updated);
    }
  }

  Future<void> removeCartItem(String itemId) async {
    if (currentUser == null) return;
    cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
    await FirebaseService.removeCartItem(currentUser!.uid, itemId);
  }

  Future<void> toggleWishlist(ProductModel product) async {
    if (currentUser == null) return;
    final exists = wishlist.any((item) => item.id == product.id);
    if (exists) {
      wishlist.removeWhere((item) => item.id == product.id);
    } else {
      wishlist.add(product);
    }
    notifyListeners();
    await FirebaseService.toggleWishlistItem(currentUser!.uid, product, exists);
  }

  Future<void> placeOrder(String shippingAddress) async {
    if (currentUser == null || cartItems.isEmpty) return;
    await FirebaseService.placeOrder(currentUser!.uid, cartItems, shippingAddress);
    orders = await FirebaseService.fetchOrders(currentUser!.uid);
    cartItems = [];
    notifyListeners();
  }

  int get cartCount => cartItems.fold<int>(0, (previousValue, item) => previousValue + item.quantity);
  int get wishlistCount => wishlist.length;
  int get ordersCount => orders.length;
}
