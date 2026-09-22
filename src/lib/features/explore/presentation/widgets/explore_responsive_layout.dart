import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../widgets/country_list_tile.dart';
import '../widgets/country_search_field.dart';
import '../widgets/pagination_bar.dart';
import '../widgets/region_filter_bar.dart';

class ExploreMobileLayout extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final String? selectedRegion;
  final VoidCallback onOpenRegionPicker;
  final VoidCallback onClearRegion;
  final List<Country> countries;
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<Country> onCountryTap;

  const ExploreMobileLayout({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedRegion,
    required this.onOpenRegionPicker,
    required this.onClearRegion,
    required this.countries,
    required this.page,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ExploreContent(
      wide: false,
      searchController: searchController,
      onSearchChanged: onSearchChanged,
      selectedRegion: selectedRegion,
      onOpenRegionPicker: onOpenRegionPicker,
      onClearRegion: onClearRegion,
      countries: countries,
      page: page,
      totalPages: totalPages,
      onPrevious: onPrevious,
      onNext: onNext,
      onCountryTap: onCountryTap,
    );
  }
}

class ExploreDesktopLayout extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final String? selectedRegion;
  final VoidCallback onOpenRegionPicker;
  final VoidCallback onClearRegion;
  final List<Country> countries;
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<Country> onCountryTap;

  const ExploreDesktopLayout({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedRegion,
    required this.onOpenRegionPicker,
    required this.onClearRegion,
    required this.countries,
    required this.page,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: _ExploreContent(
          wide: true,
          searchController: searchController,
          onSearchChanged: onSearchChanged,
          selectedRegion: selectedRegion,
          onOpenRegionPicker: onOpenRegionPicker,
          onClearRegion: onClearRegion,
          countries: countries,
          page: page,
          totalPages: totalPages,
          onPrevious: onPrevious,
          onNext: onNext,
          onCountryTap: onCountryTap,
        ),
        ),
      ),
    );
  }
}

class _ExploreContent extends StatelessWidget {
  final bool wide;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final String? selectedRegion;
  final VoidCallback onOpenRegionPicker;
  final VoidCallback onClearRegion;
  final List<Country> countries;
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<Country> onCountryTap;

  const _ExploreContent({
    required this.wide,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedRegion,
    required this.onOpenRegionPicker,
    required this.onClearRegion,
    required this.countries,
    required this.page,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    final filters = wide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CountrySearchField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: RegionFilterBar(
                  selectedRegion: selectedRegion,
                  onOpenPicker: onOpenRegionPicker,
                  onClear: onClearRegion,
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CountrySearchField(
                controller: searchController,
                onChanged: onSearchChanged,
              ),
              const SizedBox(height: 12),
              RegionFilterBar(
                selectedRegion: selectedRegion,
                onOpenPicker: onOpenRegionPicker,
                onClear: onClearRegion,
              ),
            ],
          );

    return Padding(
      padding: EdgeInsets.fromLTRB(wide ? 24 : 20, 16, wide ? 24 : 20, 20),
      child: Column(
        children: [
          filters,
          const SizedBox(height: 16),
          Expanded(
            child: _CountryListCard(
              countries: countries,
              page: page,
              totalPages: totalPages,
              onPrevious: onPrevious,
              onNext: onNext,
              onCountryTap: onCountryTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryListCard extends StatelessWidget {
  final List<Country> countries;
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<Country> onCountryTap;

  const _CountryListCard({
    required this.countries,
    required this.page,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: countries.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Nenhum país encontrado.',
                    style: TextStyle(color: AppColors.textGray),
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: countries.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        color: AppColors.textGray,
                      ),
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return CountryListTile(
                          country: country,
                          onTap: () => onCountryTap(country),
                        );
                      },
                    ),
                  ),
                  PaginationBar(
                    page: page,
                    totalPages: totalPages,
                    onPrevious: onPrevious,
                    onNext: onNext,
                  ),
                ],
              ),
      ),
    );
  }
}
