import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Barra inferior da lista com "página / total" e setas de navegação.
class PaginationBar extends StatelessWidget {
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const PaginationBar({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.textGray, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${page + 1} / $totalPages',
            style: const TextStyle(color: AppColors.textGray, fontSize: 13),
          ),
          const SizedBox(width: 8),
          _PaginationArrowButton(
            iconAsset: AppIcons.arrowLeft,
            onPressed: onPrevious,
          ),
          _PaginationArrowButton(
            iconAsset: AppIcons.arrowRight,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}

class _PaginationArrowButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onPressed;

  const _PaginationArrowButton({required this.iconAsset, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        iconAsset,
        width: 14,
        height: 14,
        color: enabled ? null : Colors.black26,
        colorBlendMode: enabled ? null : BlendMode.srcIn,
      ),
    );
  }
}
