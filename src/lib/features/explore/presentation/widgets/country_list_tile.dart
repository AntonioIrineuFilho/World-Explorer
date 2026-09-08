import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/country_flag.dart';

/// Linha de país na lista de exploração: bandeira + nome (link sublinhado).
class CountryListTile extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const CountryListTile({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          ],
        ),
      ),
    );
  }
}
