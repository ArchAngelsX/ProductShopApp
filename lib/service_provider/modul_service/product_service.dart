// ignore_for_file: unused_import, avoid_print

import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/products/product_model.dart';

class ProductService {
  Future<List<Products>> getProduct() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.in/api/products'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['products'] != null && responseData['products'] is List) {
          final List<dynamic> productsJson = responseData['products'];
          final List<Products> products = [];
          for (var item in productsJson) {
            try {
              final product = Products.fromJson(item);
              if (product.image != null) {
                product.images = [product.image!];
              }
              products.add(product);
            } catch (e) {
              print('Error parsing product: $e');
            }
          }
          return products;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error: $e');
    }
  }
}
