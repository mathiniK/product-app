import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/login_page.dart';
import 'screens/product_form_page.dart';
import 'screens/product_list_page.dart';

void main() => runApp(const App());
class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Code Manager',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/products': (_) => const ProductListPage(),
        '/create': (_) => const ProductFormPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final p = settings.arguments as Product;
          return MaterialPageRoute(builder: (_) => ProductFormPage(initial: p));
        }
        return null;
      },
    );
  }
}
