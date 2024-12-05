// ignore_for_file: unused_import, use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../service_provider/cart_product_provider.dart';
import '../../service_provider/service_provider.dart';
import '../../service_provider/order_provider.dart';
import '../../models/products/order_model.dart';

class CartProductPage extends StatelessWidget {
  final List<CartProduct> cartItems;

  const CartProductPage({Key? key, required this.cartItems}) : super(key: key);

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    double totalOrder = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    const double serviceFee = 2.0;
    double totalPayment = totalOrder + serviceFee;

    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    final currentUser = serviceProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/orderHistory'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.productName, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text(formatCurrency(item.totalPrice)),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Order:'),
                    Text(formatCurrency(totalOrder)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service Fee:'),
                    Text(formatCurrency(serviceFee)),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatCurrency(totalPayment),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your cart is empty. Please add items to proceed.')),
                      );
                      return;
                    }

                    if (currentUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please log in to proceed with payment.')),
                      );
                      return;
                    }

                    // Create order objects from cart items and add to order history
                    List<Order> orders = cartItems.map((item) {
                        return Order(itemName: item.productName, price: item.totalPrice);
                    }).toList();
                    
                    // Add orders to history
                    Provider.of<OrderProvider>(context, listen: false).addOrders(orders);
                    
                    // Clear the cart
                    Provider.of<CartProductProvider>(context, listen: false).clearCart();

                    Navigator.pushNamed(
                      context,
                      '/Confirmation',
                      arguments: {
                        'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
                        'customerName': '${currentUser.name?.firstname ?? ''} ${currentUser.name?.lastname ?? ''}',
                        'customerEmail': currentUser.email ?? '',
                        'totalPayment': totalPayment,
                        'transactionTime': DateTime.now(),
                      },
                    );
                  },
                  child: Text('Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
