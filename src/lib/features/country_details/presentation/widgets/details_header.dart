import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/country_flag.dart';

/// Cabeçalho da tela de detalhes: botão voltar + bandeira + nome do país.
class DetailsHeader extends StatelessWidget {
  final Country country;

  const DetailsHeader({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            icon: Image.asset(AppIcons.arrowLeft, width: 16, height: 16),
          ),
          const SizedBox(width: 4),
          CountryFlag(country: country, width: 32, height: 24),
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
    );
  }
}
