import 'package:flutter/material.dart';
import '../data/favorites_controller.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';

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
            // Cabeçalho: voltar + bandeira + nome
            Container(
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
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 4),
                  Text(country.flagEmoji, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      country.name,
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Cartões de informações
            _InfoCard(
              children: [
                _InfoRow(label: 'Nome oficial', value: country.officialName),
                _InfoRow(label: 'Capital', value: country.capital),
                _InfoRow(
                    label: 'População', value: country.populationFormatted),
                _InfoRow(label: 'Moeda', value: country.currency),
                _InfoRow(
                  label: 'Idiomas',
                  value: country.languagesFormatted,
                  isLast: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Botão de favoritar/remover
            ValueListenableBuilder<List<Country>>(
              valueListenable: favorites.favorites,
              builder: (context, favList, _) {
                final isFav = favorites.isFavorite(country);
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => favorites.toggleFavorite(country),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentYellow,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: Icon(
                      isFav ? Icons.star_rounded : Icons.star_border_rounded,
                    ),
                    label: Text(
                      isFav ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
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
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.divider, width: 1),
              ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
