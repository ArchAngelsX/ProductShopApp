import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/Screen/product/cart_product.dart';
import 'package:sushi_app/Screen/product/user_menu.dart';
import 'package:sushi_app/service_provider/cart_product_provider.dart';
import 'package:sushi_app/service_provider/service_provider.dart';
import 'package:sushi_app/Screen/product/product_detail.dart';
import 'order_page.dart'; // Import OrderPage

import '../../models/products/product_model.dart'; // Import the ProductDetail screen

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedIndex = 0;
  String? _selectedFilter;
  String? _selectedSort;
  String _searchQuery = '';
  List<Products> productList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false).getProductProvider();
    super.initState();
  }

  void goToDetailMenu(int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ProductDetail(
        product: productList[index],
      )
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: Text('Product Menu'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
              actions: [
                DropdownButton<String>(
                  hint: Text('Filter By'),
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue;
                    });
                  },
                  items: <String>['All', 'Audio', 'Gaming', 'Mobile', 'TV']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )
          : null, // No AppBar for other indices
      body: Consumer<ServiceProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.errorMessage != null) {
                showErrorDialog(context, value);
              }
            });
            return Center(child: Text(value.errorMessage ?? 'An error occurred'));
          } else if (value.products.isEmpty) {
            return Center(
              child: Text('No products available'),
            );
          } else {
            switch (_selectedIndex) {
              case 0: // Home
                return productListWidget(value); // Your product list widget
              case 1: // My Cart
                return CartProductPage(cartItems: Provider.of<CartProductProvider>(context).items); // Replace with your cart page widget
              case 2: // My Order
                return const OrderPage(); // Use the new OrderPage implementation
              case 3: // User
                return UserMenu(); // Replace with your user page widget
              default:
                return productListWidget(value); // Default to product list
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'User',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  showErrorDialog(BuildContext context, ServiceProvider value) {
    return showDialog(
      barrierColor: Colors.grey.withOpacity(0.5),
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(value.errorMessage!),
          actions: [
            TextButton(
              onPressed: () {
                value.getProductProvider();
                Navigator.pop(context);
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                value.clearErrorMessage();
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget productListWidget(ServiceProvider value) {
    return RefreshIndicator(
      onRefresh: () => value.getProductProvider(),
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 4.25,
        ),
        itemCount: value.products
            .where((product) => 
                (_selectedFilter == null || _selectedFilter == 'All' || product.category?.toLowerCase() == _selectedFilter?.toLowerCase()) &&
                product.title!.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
            .toList()
            .length,
        itemBuilder: (context, index) {
          final filteredProducts = value.products.where((product) => 
              (_selectedFilter == null || _selectedFilter == 'All' || product.category?.toLowerCase() == _selectedFilter?.toLowerCase()) &&
              product.title!.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false
          ).toList();
          
          if (filteredProducts.isEmpty) {
            return Center(
              child: Text('No products found'),
            );
          }
          
          final product = filteredProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(product: product), // Navigate to ProductDetail
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      color: Colors.white,
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        product.images?.first ?? product.image ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: Center(
                              child: Text('Image not available'),
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$ ${product.price != null ? product.price!.toStringAsFixed(0).replaceAll(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), r'$1,') : '0'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}