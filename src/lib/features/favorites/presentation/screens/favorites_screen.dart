import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/models/country.dart';
import '../../data/favorites_controller.dart';
import '../widgets/favorites_responsive_layout.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final favorites = context.watch<FavoritesStore>();
            final favList = favorites.favorites;

            void openDetails(Country country) {
              Navigator.of(context).pushNamed(AppRoutes.details, arguments: country);
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
        ),
      );
  }
}
