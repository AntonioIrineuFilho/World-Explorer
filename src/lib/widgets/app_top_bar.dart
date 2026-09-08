import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Cabeçalho "World Explorer" com o ícone de globo, presente no topo
/// das três telas do protótipo.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.public, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          const Text(
            'World Explorer',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
