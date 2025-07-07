class ProductModel {
  late int productID;
  late String productName;
  late double prices;
  late int stock;
  ProductModel({
    this.productID = 0,
    required this.productName,
    required this.prices,
    required this.stock,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['PRODUCTID'] ?? 0,
      productName: json['PRODUCTNAME'] ?? 'Unknown',
      prices: json['PRICE'] != null ? (json['PRICE'] as num).toDouble() : 0.0,
      stock: json['STOCK'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {'productName': productName, 'price': prices, 'stock': stock};
  }
}
