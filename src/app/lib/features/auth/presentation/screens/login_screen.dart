import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/auth_controller.dart';
import '../../../../core/constants/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(); final _password = TextEditingController();
  bool _obscure = true;
  @override void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthController>();
    try {
      await auth.login(_email.text.trim(), _password.text);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.consultation, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Entrar')),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Icon(Icons.public, size: 64, color: Color(0xFF254D8D)), const SizedBox(height: 16),
        Text('Acesse sua conta', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center), const SizedBox(height: 28),
        TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email_outlined)), validator: (v) => v == null || !v.contains('@') ? 'Informe um e-mail válido' : null),
        const SizedBox(height: 16), TextFormField(controller: _password, obscureText: _obscure, decoration: InputDecoration(labelText: 'Senha', border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _obscure = !_obscure))), validator: (v) => v == null || v.length < 8 ? 'A senha deve ter ao menos 8 caracteres' : null),
        const SizedBox(height: 24), Consumer<AuthController>(builder: (_, auth, __) => ElevatedButton(onPressed: auth.isLoading ? null : _submit, child: auth.isLoading ? const CircularProgressIndicator() : const Text('Entrar'))),
        TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.register), child: const Text('Não tem conta? Cadastre-se')),
      ]))))),
  );
}
