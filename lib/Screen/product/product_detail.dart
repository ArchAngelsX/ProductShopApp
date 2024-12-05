import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/Screen/product/product_screen.dart';
import 'package:sushi_app/models/products/product_model.dart';
import 'package:sushi_app/service_provider/cart_product_provider.dart';
import 'package:sushi_app/Screen/product/cart_product.dart';

class ProductDetail extends StatefulWidget {
  final Products product;

  const ProductDetail({
    super.key, 
    required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 1;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _updateTotalPrice();
  }

  void incrementQuantity() {
    setState(() {
      _quantity+=1;
      _updateTotalPrice();
      print('Quantity increased to: $_quantity'); // Debug print
    });
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity-=1;
        _updateTotalPrice();
        print('Quantity decreased to: $_quantity'); // Debug print
      });
    }
  }

  void _updateTotalPrice() {
    _totalPrice = (widget.product.price ?? 0).toDouble() * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? 'Product Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartProductPage(
                    cartItems: Provider.of<CartProductProvider>(context).items,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: PageView.builder(
                itemCount: widget.product.images?.length ?? 1,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.product.images![index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${widget.product.category ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Brand: ${widget.product.brand ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Model: ${widget.product.model ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Color: ${widget.product.color ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$ ${_totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.description ?? 'No description available.',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: decrementQuantity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          _quantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: incrementQuantity,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProductProvider>(context, listen: false).addItem(
                          CartProduct(
                            productName: widget.product.title ?? '',
                            price: (widget.product.price ?? 0).toDouble(),
                            quantity: _quantity,
                          ),
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Item Added to Cart'),
                              content: const Text('Would you like to continue shopping or go to the cart?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Continue Shopping'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartProductPage(
                                          cartItems: Provider.of<CartProductProvider>(context).items,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Go to Cart'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
