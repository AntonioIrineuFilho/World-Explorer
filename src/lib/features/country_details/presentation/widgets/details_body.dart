import 'package:flutter/material.dart';
import '../../../../shared/models/country.dart';
import '../../../favorites/data/favorites_controller.dart';
import 'details_header.dart';
import 'favorite_action_button.dart';
import 'info_card.dart';

/// Conteúdo dos detalhes de um país.
///
/// O conteúdo principal tem largura limitada pela tela e pelo pai. O card
/// acompanha essa largura, enquanto o botão de favoritos possui uma largura
/// máxima própria e permanece alinhado à esquerda do conteúdo.
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
    final favorites = FavoritesController.instance;

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
              child: ValueListenableBuilder<List<Country>>(
                valueListenable: favorites.favorites,
                builder: (context, favList, _) {
                  final isFav = favorites.isFavorite(country);
                  return FavoriteActionButton(
                    isFavorite: isFav,
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
