import 'package:flutter/material.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../favorites/data/favorites_controller.dart';
import '../widgets/details_header.dart';
import '../widgets/favorite_action_button.dart';
import '../widgets/info_card.dart';

class DetailsScreen extends StatelessWidget {
  final Country country;

  const DetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesController.instance;

    return Scaffold(
      appBar: const AppTopBar(),
      bottomNavigationBar: const AppBottomNav(currentTab: AppTab.explore),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            DetailsHeader(country: country),
            const SizedBox(height: 16),
            InfoCard(country: country),
            const SizedBox(height: 20),
            ValueListenableBuilder<List<Country>>(
              valueListenable: favorites.favorites,
              builder: (context, favList, _) {
                final isFav = favorites.isFavorite(country);
                return FavoriteActionButton(
                  isFavorite: isFav,
                  onPressed: () => favorites.toggleFavorite(country),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
