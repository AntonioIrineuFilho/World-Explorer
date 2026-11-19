import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/auth_controller.dart';
import '../../data/auth_service.dart';
import '../../../../core/constants/app_routes.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});
  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    try {
      await context.read<AuthController>().loadProfile();
      if (mounted) setState(() => _loading = false);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error.toString();
      });
      if (error is ApiException && error.statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    }
  }

  Future<void> _logout() async {
    Navigator.pop(context);
    try {
      await context.read<AuthController>().logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de dados'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
        ),
        actions: [
          Builder(builder: (context) => IconButton(
            tooltip: 'Abrir menu',
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          )),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Bem-vindo, ${user?.name ?? ''}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _loading
              ? const CircularProgressIndicator()
              : _error != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!),
                        ElevatedButton(onPressed: _load, child: const Text('Tentar novamente')),
                      ],
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dados retornados pela API', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 20),
                            _item('ID', user!.id.toString()),
                            _item('Nome', user.name),
                            _item('E-mail', user.email),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget _item(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
            Expanded(child: Text(value)),
          ],
        ),
      );
}
