import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/models/sushi/cart_model.dart';
import 'package:sushi_app/Screen/Sushi_app/provider/cart.dart';

class CartPage extends StatelessWidget {
  final List<CartModel> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          if (cart.cart.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cart.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      item: cart.cart[index],
                      onRemove: () => cart.removeFromCart(index),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: IDR ${NumberFormat('#,###').format(cart.totalAmount)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your checkout logic here
                        cart.clearCart();
                        Navigator.pop(context);
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartModel item;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        item.imgPath ?? 'assets/images/default.png',
        width: 50,
        height: 50,
        fit: BoxFit.cover
      ),
      title: Text(item.name ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('IDR ${NumberFormat('#,###').format(item.price ?? 0)}'),
          Text('Quantity: ${item.quantity}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(CupertinoIcons.trash),
        onPressed: onRemove,
      ),
    );
  }
}
