import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class RegionPickerSheet extends StatelessWidget {
  final List<String> regions;
  final String? selectedRegion;

  const RegionPickerSheet({
    super.key,
    required this.regions,
    required this.selectedRegion,
  });

  static Future<String?> show(
    BuildContext context, {
    required List<String> regions,
    required String? selectedRegion,
  }) {
    return showModalBottomSheet<String?>(
      context: context,
      backgroundColor: AppColors.cardWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => RegionPickerSheet(
        regions: regions,
        selectedRegion: selectedRegion,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filtrar por região',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Todas as regiões'),
            trailing: selectedRegion == null
                ? const Icon(Icons.check, color: AppColors.primaryBlue)
                : null,
            onTap: () => Navigator.pop(context, null),
          ),
          ...regions.map(
            (region) => ListTile(
              title: Text(region),
              trailing: selectedRegion == region
                  ? const Icon(Icons.check, color: AppColors.primaryBlue)
                  : null,
              onTap: () => Navigator.pop(context, region),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
