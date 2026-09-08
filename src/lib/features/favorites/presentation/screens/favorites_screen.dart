import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../country_details/presentation/screens/details_screen.dart';
import '../../data/favorites_controller.dart';
import '../widgets/favorite_list_tile.dart';
import '../widgets/favorites_header.dart';

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
              const FavoritesHeader(),
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
                          color: AppColors.textGray,
                        ),
                        itemBuilder: (context, index) {
                          final country = favList[index];
                          return FavoriteListTile(
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
