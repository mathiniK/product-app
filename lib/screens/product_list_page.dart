import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/auth_service.dart'; // <-- add this import

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _q = TextEditingController();
  List<Product> _items = [];
  bool _loading = false;

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      _items = await ProductService.search(_q.text);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.logout();        // clear stored token
              if (mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  '/',                             // back to login screen
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.pushNamed(context, '/create');
          if (created == true) _search();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _q,
              decoration: InputDecoration(
                labelText: 'Search by code or name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 12),
            if (_loading) const LinearProgressIndicator(),
            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final p = _items[i];
                  return ListTile(
                    title: Text('${p.productCode} — ${p.productName}'),
                    subtitle: Text('Price: ${p.price.toStringAsFixed(2)}'),
                    onTap: () async {
                      final updated = await Navigator.pushNamed(
                        context,
                        '/edit',
                        arguments: p,
                      );
                      if (updated == true) _search();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
