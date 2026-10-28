import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/models/country.dart';
import '../../../favorites/data/favorites_controller.dart';
import 'details_header.dart';
import 'favorite_action_button.dart';
import 'info_card.dart';

class DetailsBody extends StatelessWidget {
  final Country country;
  final VoidCallback onBack;

  const DetailsBody({
    super.key,
    required this.country,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DetailsHeader(country: country, onBack: onBack),
        const SizedBox(height: 16),
        InfoCard(country: country),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: SizedBox(
              width: double.infinity,
              child: Consumer<FavoritesStore>(
                builder: (context, favorites, _) {
                  return FavoriteActionButton(
                    isFavorite: favorites.isFavorite(country),
                    onPressed: () => favorites.toggleFavorite(country),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
