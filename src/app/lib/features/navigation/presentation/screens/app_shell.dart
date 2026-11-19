import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/data/auth_controller.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/navigation/app_route_builder.dart';
import '../../../explore/presentation/screens/explore_screen.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;

  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;

  final _navigatorKeys = <GlobalKey<NavigatorState>>[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 1).toInt();
  }

  Future<bool> _handleBack() async {
    final navigator = _navigatorKeys[_currentIndex].currentState!;

    if (navigator.canPop()) {
      navigator.pop();
      return false;
    }

    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }

    return true;
  }

  Navigator _buildTabNavigator({
    required int index,
    required Widget child,
  }) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.details) {
          return AppRouteBuilder.build(settings);
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => child,
        );
      },
    );
  }

  void _selectTab(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }
    setState(() => _currentIndex = index);
  }

  Future<void> _openSettings() async {
    Navigator.of(context).pop();
    final result = await Navigator.of(context).pushNamed(AppRoutes.settings);

    if (!mounted || result != true) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Configurações concluídas')),
      );
  }

  Future<void> _openLogin() async {
    Navigator.of(context).pop();
    await Navigator.of(context).pushNamed(AppRoutes.login);
  }

  Future<void> _logout() async {
    Navigator.of(context).pop();
    try {
      await context.read<AuthController>().logout();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Você saiu da sua conta.')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void _showAbout() {
    Navigator.of(context).pop();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sobre'),
        content: const Text(
          'World Explorer é um aplicativo que permite entusiastas sobre países encontrar diversas informações úteis com facilidade e praticidade.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBack,
      child: Scaffold(
        appBar: const AppTopBar(),
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Consumer<AuthController>(builder: (context, auth, _) => DrawerHeader(
                  child: Center(child: auth.isAuthenticated
                    ? Text('Bem-vindo, ${auth.user!.name}!', textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    : const Text('World Explorer', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                )),
                Consumer<AuthController>(builder: (context, auth, _) => auth.isAuthenticated
                  ? const SizedBox.shrink()
                  : ListTile(leading: const Icon(Icons.login), title: const Text('Entrar'), onTap: _openLogin)),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Configurações'),
                  onTap: _openSettings,
                ),
                ListTile(leading: const Icon(Icons.info_outline), title: const Text('Sobre'), onTap: _showAbout),
                const Spacer(),
                Consumer<AuthController>(builder: (context, auth, _) => auth.isAuthenticated
                  ? ListTile(leading: const Icon(Icons.logout), title: const Text('Sair'), onTap: _logout)
                  : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTabNavigator(
              index: 0,
              child: const ExploreScreen(),
            ),
            _buildTabNavigator(
              index: 1,
              child: const FavoritesScreen(),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentTab: _currentIndex == 0 ? AppTab.explore : AppTab.favorites,
          onTabSelected: _selectTab,
        ),
      ),
    );
  }
}
