import 'package:flutter/material.dart';
import '../data/favorites_controller.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesController.instance;

    return Scaffold(
      appBar: const AppTopBar(),
      bottomNavigationBar: const AppBottomNav(currentTab: AppTab.favorites),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cabeçalho: voltar + estrela + "Meus favoritos"
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primaryBlue),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star_border_rounded,
                        color: AppColors.primaryBlue, size: 24),
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
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ValueListenableBuilder<List<Country>>(
                  valueListenable: favorites.favorites,
                  builder: (context, favList, _) {
                    if (favList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_border_rounded,
                                size: 48, color: Colors.black26),
                            const SizedBox(height: 12),
                            const Text(
                              'Você ainda não tem países favoritos.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
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
                      clipBehavior: Clip.antiAlias,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: favList.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: AppColors.divider,
                        ),
                        itemBuilder: (context, index) {
                          final country = favList[index];
                          return _FavoriteTile(
                            country: country,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(country: country),
                                ),
                              );
                            },
                            onRemove: () => favorites.removeFavorite(country),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteTile({
    required this.country,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(country.flagEmoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryBlue,
                ),
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete_outline,
                  color: AppColors.deleteRed),
            ),
          ],
        ),
      ),
    );
  }
}
