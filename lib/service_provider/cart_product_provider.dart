// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';

class CartProduct {
  final String productName;
  final double price;
  int quantity;

  CartProduct({
    required this.productName,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity; // Adding totalPrice getter
}

class CartProductProvider with ChangeNotifier {
  List<CartProduct> _items = [];

  List<CartProduct> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice); // Using totalPrice getter
  }

  void addItem(CartProduct item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartProduct item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartProduct item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
