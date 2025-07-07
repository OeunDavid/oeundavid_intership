import 'package:flutter/material.dart';
import 'package:products/core/services/app_service.dart';
import 'package:products/models/product_model.dart';

class EditProductProvider with ChangeNotifier {
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  bool get isLoading => _isLoading;

  void loadProductData(ProductModel product) {
    nameController.text = product.productName;
    priceController.text = product.prices.toString();
    stockController.text = product.stock.toString();
  }

  Future<bool> editProduct(ProductModel oldProduct) async {
    final nameText = nameController.text.trim();
    final priceText = priceController.text.trim();
    final stockText = stockController.text.trim();

    // Check if all fields are empty
    if (nameText.isEmpty && priceText.isEmpty && stockText.isEmpty) {
      print("Please fill at least one field.");
      return false;
    }

    final name = nameText.isNotEmpty ? nameText : oldProduct.productName;
    final price =
        priceText.isNotEmpty ? double.tryParse(priceText) : oldProduct.prices;
    final stock =
        stockText.isNotEmpty ? int.tryParse(stockText) : oldProduct.stock;

    if ((priceText.isNotEmpty && price == null) ||
        (stockText.isNotEmpty && stock == null)) {
      print("Invalid number format for price or stock.");
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final updated = ProductModel(
        productID: oldProduct.productID,
        productName: name.isNotEmpty ? name : oldProduct.productName,
        prices: price ?? oldProduct.prices,
        stock: stock ?? oldProduct.stock,
      );

      final updatedProduct = await AppService.updateProduct(updated);

      return true;
    } catch (e) {
      print("Edit product failed: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
