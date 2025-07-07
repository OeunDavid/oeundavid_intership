import 'package:flutter/material.dart';
import 'package:products/core/services/app_service.dart';
import 'package:products/models/product_model.dart';

class AddproductProvider with ChangeNotifier {
  bool _isLoading = false;
  final List<ProductModel> _products = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  bool get isLoading => _isLoading;
  List<ProductModel> get products => List.unmodifiable(_products);

  get formKey => null;

  Future<bool> addProduct() async {
    var name = nameController.text.trim();
    var price = double.tryParse(priceController.text);
    var stock = int.tryParse(stockController.text);

    if (name.isEmpty || price == null || stock == null) {
      print("Invalid input: name, price, or stock is missing/invalid.");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final newProduct = await AppService.addProduct(
        ProductModel(productName: name, prices: price, stock: stock),
      );
      _products.add(newProduct);

      nameController.clear();
      priceController.clear();
      stockController.clear();

      return true;
    } catch (e) {
      print("Add product failed: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
