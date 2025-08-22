import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState() => _LoginPageState(); }

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _u = TextEditingController(text: 'admin');
  final _p = TextEditingController(text: 'admin123');
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: _u, decoration: const InputDecoration(labelText: 'Username'), validator: (v)=>v!.isEmpty?'Required':null),
              TextFormField(controller: _p, decoration: const InputDecoration(labelText: 'Password'), obscureText: true, validator: (v)=>v!.isEmpty?'Required':null),
              const SizedBox(height: 12),
              if (_error!=null) Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : () async {
                  if (!_form.currentState!.validate()) return;
                  setState(()=>_loading=true);
                  final ok = await AuthService.login(_u.text, _p.text);
                  setState(()=>_loading=false);
                  if (ok && mounted) Navigator.pushReplacementNamed(context, '/products');
                  else setState(()=>_error='Invalid credentials');
                },
                child: Text(_loading ? 'Signing in...' : 'Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
