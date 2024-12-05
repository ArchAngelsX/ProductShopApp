import 'package:flutter/foundation.dart';
import '../models/products/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrders(List<Order> newOrders) {
    _orders.addAll(newOrders);
    notifyListeners();
  }
}
