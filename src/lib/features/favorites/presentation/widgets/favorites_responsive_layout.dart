import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../widgets/favorite_list_tile.dart';
import '../widgets/favorites_header.dart';

class FavoritesMobileLayout extends StatelessWidget {
  final List<Country> favorites;
  final ValueChanged<Country> onTap;
  final ValueChanged<Country> onRemove;

  const FavoritesMobileLayout({
    super.key,
    required this.favorites,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return _FavoritesContent(
      favorites: favorites,
      onTap: onTap,
      onRemove: onRemove,
    );
  }
}

class FavoritesDesktopLayout extends StatelessWidget {
  final List<Country> favorites;
  final ValueChanged<Country> onTap;
  final ValueChanged<Country> onRemove;

  const FavoritesDesktopLayout({
    super.key,
    required this.favorites,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: _FavoritesContent(
          favorites: favorites,
          onTap: onTap,
          onRemove: onRemove,
        ),
        ),
      ),
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  final List<Country> favorites;
  final ValueChanged<Country> onTap;
  final ValueChanged<Country> onRemove;
  const _FavoritesContent({
    required this.favorites,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          const FavoritesHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppIcons.star,
                          width: 48,
                          height: 48,
                          color: Colors.black26,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Você ainda não tem países favoritos.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textGray),
                        ),
                      ],
                    ),
                  )
                : DecoratedBox(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: favorites.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: AppColors.textGray,
                        ),
                        itemBuilder: (context, index) {
                          final country = favorites[index];
                          return FavoriteListTile(
                            country: country,
                            onTap: () => onTap(country),
                            onRemove: () => onRemove(country),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
