import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static const baseUrl = 'http://10.0.2.2:5000/api'; // Android emulator to localhost
  static const storage = FlutterSecureStorage();

  static Future<String?> getToken() => storage.read(key: 'token');
  static Future<void> setToken(String token) => storage.write(key: 'token', value: token);
  static Future<void> clearToken() => storage.delete(key: 'token');

  static Future<http.Response> post(String path, Map<String, dynamic> body, {bool auth = true}) async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (auth) {
      final t = await getToken();
      if (t != null) headers['Authorization'] = 'Bearer $t';
    }
    return http.post(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> put(String path, Map<String, dynamic> body) async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    final t = await getToken();
    if (t != null) headers['Authorization'] = 'Bearer $t';
    return http.put(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> get(String path) async {
    final headers = <String, String>{};
    final t = await getToken();
    if (t != null) headers['Authorization'] = 'Bearer $t';
    return http.get(Uri.parse('$baseUrl$path'), headers: headers);
  }
}
