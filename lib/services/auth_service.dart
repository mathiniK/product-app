import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class AuthService {
  static Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('${ApiClient.baseUrl}/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      final token = (jsonDecode(res.body))['token'] as String;
      await ApiClient.setToken(token);
      return true;
    }
    return false;
  }

  static Future<void> logout() => ApiClient.clearToken();
}
