import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'api_client.dart';

class ProductService {
  static Future<List<Product>> search(String q) async {
    final res = await ApiClient.get('/product/search?query=$q');
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Search failed: ${res.statusCode}');
  }

  static Future<void> create(Product p) async {
    final res = await ApiClient.post('/product', p.toJson(), auth: true);
    if (res.statusCode != 201) {
      throw Exception('Create failed: ${res.statusCode} ${res.body}');
    }
  }

  static Future<void> update(Product p) async {
    final res = await ApiClient.put('/product/${p.id}', p.toJson());
    if (res.statusCode != 204) {
      throw Exception('Update failed: ${res.statusCode} ${res.body}');
    }
  }
}
