import 'package:flutter/material.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_theme.dart';

enum AppTab { explore, favorites }

class AppBottomNav extends StatelessWidget {
  final AppTab currentTab;
  final ValueChanged<int> onTabSelected;

  const AppBottomNav({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.cardWhite,
        border: Border(top: BorderSide(color: AppColors.textGray, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              _NavItem(
                iconAsset: AppIcons.home,
                label: 'Explorar',
                selected: currentTab == AppTab.explore,
                onTap: () => onTabSelected(0),
              ),
              _NavItem(
                iconAsset: AppIcons.star,
                tintColor: AppColors.buttonBlue,
                label: 'Favoritos',
                selected: currentTab == AppTab.favorites,
                onTap: () => onTabSelected(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconAsset;
  final Color? tintColor;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconAsset,
    this.tintColor,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const color = AppColors.buttonBlue;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: 26,
              height: 26,
              color: tintColor,
              colorBlendMode: tintColor != null ? BlendMode.srcIn : null,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
