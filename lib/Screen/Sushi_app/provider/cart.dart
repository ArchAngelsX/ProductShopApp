import 'package:flutter/cupertino.dart';
import 'package:sushi_app/models/sushi/cart_model.dart';
import 'package:sushi_app/models/sushi/menu_sushi.dart';

class Cart extends ChangeNotifier {
  final List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;
  
  // Get total number of items in cart
  int get itemCount => _cart.fold(0, (sum, item) => sum + (item.quantity ?? 1));

  // Get total amount of all items in cart
  double get totalAmount {
    return _cart.fold(0.0, (sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 1));
  }

  // Check if an item exists in cart
  bool isInCart(String? name) {
    return _cart.any((item) => item.name == name);
  }

  // Get cart item by index
  CartModel? getItem(int index) {
    if (index >= 0 && index < _cart.length) {
      return _cart[index];
    }
    return null;
  }

  // Add item to cart
  void addToCart(Menu foodItem, int qty) {
    if (foodItem.name != null && foodItem.price != null && foodItem.imgPath != null) {
      // Check if item already exists in cart
      int existingIndex = _cart.indexWhere((item) => item.name == foodItem.name);
      
      if (existingIndex != -1) {
        // Update quantity if item exists
        _cart[existingIndex].quantity = (_cart[existingIndex].quantity ?? 0) + qty;
      } else {
        // Add new item if it doesn't exist
        _cart.add(
          CartModel(
            name: foodItem.name,
            price: foodItem.price,
            imgPath: foodItem.imgPath,
            quantity: qty
          ),
        );
      }
      notifyListeners();
    } else {
      throw Exception('Invalid Menu item');
    }
  }
  
  // Remove item from cart
  void removeFromCart(int index) {
    if (index >= 0 && index < _cart.length) {
      _cart.removeAt(index);
      notifyListeners();
    }
  }

  // Update item quantity
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _cart.length) {
      _cart[index].quantity = quantity;
      if (quantity <= 0) {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Clear all items from cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
