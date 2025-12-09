import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Add item to cart
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Increase quantity
      _items[product.id]!.quantity++;
    } else {
      // Add new item
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Decrease quantity
  void decreaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;
    _items[productId]!.quantity++;
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Check if product is in cart
  bool isInCart(int productId) {
    return _items.containsKey(productId);
  }

  // Get quantity of a product
  int getQuantity(int productId) {
    return _items[productId]?.quantity ?? 0;
  }
}
