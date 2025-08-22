import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductFormPage extends StatefulWidget {
  final Product? initial;
  const ProductFormPage({super.key, this.initial});
  @override State<ProductFormPage> createState()=>_ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _price = TextEditingController();
  bool _saving = false;
  String? _error;

  @override void initState() {
    super.initState();
    if (widget.initial != null) {
      _code.text = widget.initial!.productCode;
      _name.text = widget.initial!.productName;
      _price.text = widget.initial!.price.toString();
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final isEdit = widget.initial != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Product' : 'New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: _code, decoration: const InputDecoration(labelText: 'Product Code'), validator: (v)=>v!.isEmpty?'Required':null),
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Product Name'), validator: (v)=>v!.isEmpty?'Required':null),
              TextFormField(
                controller: _price, decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v){
                  if (v==null || v.isEmpty) return 'Required';
                  final n = double.tryParse(v); if (n==null) return 'Must be numeric';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              if (_error!=null) Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _saving ? null : () async {
                  if (!_form.currentState!.validate()) return;
                  setState(()=>_saving=true);
                  try {
                    if (isEdit) {
                      await ProductService.update(Product(
                        id: widget.initial!.id,
                        productCode: _code.text, productName: _name.text,
                        price: double.parse(_price.text),
                      ));
                      if (mounted) Navigator.pop(context, true);
                    } else {
                      await ProductService.create(Product(
                        id: 0, productCode: _code.text,
                        productName: _name.text, price: double.parse(_price.text),
                      ));
                      if (mounted) Navigator.pop(context, true);
                    }
                  } catch (e) {
                    setState(()=>_error=e.toString());
                  } finally {
                    setState(()=>_saving=false);
                  }
                },
                child: Text(_saving ? 'Saving...' : (isEdit ? 'Update' : 'Create')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
