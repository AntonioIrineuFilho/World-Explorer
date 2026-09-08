import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Cabeçalho "← ⭐ Meus favoritos" no topo da tela de favoritos.
class FavoritesHeader extends StatelessWidget {
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Image.asset(AppIcons.arrowLeft, width: 16, height: 16),
          ),
          const SizedBox(width: 4),
          // Cor nativa do ícone (#254D8D) já é a azul principal, correta
          // para um título de cabeçalho.
          Image.asset(AppIcons.star, width: 24, height: 24),
          const SizedBox(width: 10),
          const Text(
            'Meus favoritos',
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
}
