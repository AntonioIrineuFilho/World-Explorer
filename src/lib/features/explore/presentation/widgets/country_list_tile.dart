import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/country_flag.dart';

class CountryListTile extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CountryListTile({
    super.key,
    required this.country,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
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
