import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/country_flag.dart';

/// Linha de país favoritado: bandeira + nome (link) + botão de excluir.
class FavoriteListTile extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavoriteListTile({
    super.key,
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
            CountryFlag(country: country),
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
              icon: Image.asset(AppIcons.trash, width: 20, height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
