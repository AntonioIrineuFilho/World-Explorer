import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Botão "Região" + chip com a região selecionada (com X para limpar),
/// exibidos logo abaixo do campo de busca.
class RegionFilterBar extends StatelessWidget {
  final String? selectedRegion;
  final VoidCallback onOpenPicker;
  final VoidCallback onClear;

  const RegionFilterBar({
    super.key,
    required this.selectedRegion,
    required this.onOpenPicker,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onOpenPicker,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.buttonBlue,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Image.asset(AppIcons.filter, width: 16, height: 16),
                const SizedBox(width: 6),
                const Text(
                  'Região',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
        if (selectedRegion != null) ...[
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.buttonBlue),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      selectedRegion!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.buttonBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: onClear,
                    child: Image.asset(AppIcons.close, width: 14, height: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
