import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:products/models/product_model.dart';

class AppService {
  static const String baseUrl = "http://10.0.2.2:3000/api";
  static const String productEndpoint = "/products";

  // Get all products
  static Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    final url = Uri.parse('$baseUrl$productEndpoint?page=$page&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> productList = jsonMap['products'];
      return productList.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$productEndpoint/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load product");
    }
  }

  static Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + productEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 201) {
        return ProductModel.fromJson(json.decode(response.body));
      } else {
        print("Server Error: ${response.statusCode} - ${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print("Network or parsing error: $e");
      throw Exception("An error occurred while adding the product.");
    }
  }

  static Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await http.put(
      Uri.parse('$baseUrl$productEndpoint/${product.productID}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update product");
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$productEndpoint/$id'),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete product");
    }
  }
}
