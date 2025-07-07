import 'package:flutter/material.dart';
import 'package:products/core/services/app_service.dart';
import 'package:products/models/product_model.dart';
import 'package:products/routes/route_name.dart';
import 'package:provider/provider.dart';

class ProductProviders with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  bool _hasError = false;

  String? get errorMessage => _errorMessage;
  bool get hasError => _hasError;

  Future<void> fetchInitialProducts() async {
    _products.clear();
    _currentPage = 1;
    _hasMore = true;
    await fetchProducts();
  }

  Future<void> fetchProducts({bool reset = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      if (reset) {
        _currentPage = 1;
        _products.clear();
        _hasMore = true;
      }
      final newProducts = await AppService.getProducts(
        page: _currentPage,
        limit: _limit,
      );
      if (newProducts.isEmpty || newProducts.length < _limit) {
        _hasMore = false;
      }

      _products.addAll(newProducts);
      // _hasMore = newProducts.length == _limit;
      _currentPage++;
    } catch (e) {
      print('Fetch error: $e');
      _hasError = true;
      _errorMessage = "Failed to load products. Please try again.";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProductById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final product = await AppService.getProductById(id);
      _products = [product];
    } catch (e) {
      print("Fetch by ID failed: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> navigateToAddProductAndRefresh(BuildContext context) async {
    final result = await Navigator.pushNamed(context, RoutesName.add);
    if (result == true) {
      await fetchProducts(reset: true);
    }
  }

  Future<void> navigateToEditProduct(
    BuildContext context,
    ProductModel product,
  ) async {
    await Navigator.pushNamed(context, RoutesName.edit, arguments: product);
  }

  Future<void> updateProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();
    try {
      final updatedProduct = await AppService.updateProduct(product);
      final index = _products.indexWhere(
        (p) => p.productID == updatedProduct.productID,
      );
      if (index != -1) {
        _products[index] = updatedProduct;
      }
    } catch (e) {
      print("Update product failed: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await AppService.deleteProduct(id);
      _products.removeWhere((p) => p.productID == id);
    } catch (e) {
      print("Delete product failed: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
