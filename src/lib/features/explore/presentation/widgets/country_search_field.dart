import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Campo de busca "Buscar país..." do topo da tela de exploração.
class CountrySearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CountrySearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.textGray),
      decoration: InputDecoration(
        hintText: 'Buscar país...',
        hintStyle: const TextStyle(color: AppColors.textGray),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: Image.asset(AppIcons.search, width: 18, height: 18),
        ),
        filled: true,
        fillColor: AppColors.cardWhite,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
