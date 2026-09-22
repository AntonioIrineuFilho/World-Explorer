import 'package:flutter/material.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../country_details/presentation/screens/details_screen.dart';
import '../../data/favorites_controller.dart';
import '../widgets/favorites_responsive_layout.dart';

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ValueListenableBuilder<List<Country>>(
              valueListenable: favorites.favorites,
              builder: (context, favList, _) {
                void openDetails(Country country) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(country: country),
                    ),
                  );
                }

                return constraints.maxWidth >= 700
                    ? FavoritesDesktopLayout(
                        favorites: favList,
                        onTap: openDetails,
                        onRemove: favorites.removeFavorite,
                      )
                    : FavoritesMobileLayout(
                        favorites: favList,
                        onTap: openDetails,
                        onRemove: favorites.removeFavorite,
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
