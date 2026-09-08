import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';

class FavoriteActionButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const FavoriteActionButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.favoriteYellow,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        icon: Image.asset(
          AppIcons.star,
          width: 18,
          height: 18,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
        ),
        label: Text(
          isFavorite ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
