import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/products/order_model.dart';
import '../../service_provider/order_provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          final orders = orderProvider.orders;
          
          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders yet'),
            );
          }
          
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    order.itemName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Price: \$${order.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
