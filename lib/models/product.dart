class Product {
  final int id;
  final String productCode;
  final String productName;
  final double price;

  Product({required this.id, required this.productCode, required this.productName, required this.price});

  factory Product.fromJson(Map<String, dynamic> j) => Product(
    id: j['id'] ?? 0,
    productCode: j['productCode'],
    productName: j['productName'],
    price: (j['price'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'productCode': productCode,
    'productName': productName,
    'price': price,
  };
}
