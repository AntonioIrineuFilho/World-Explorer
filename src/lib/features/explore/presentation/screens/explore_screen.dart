import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../country_details/presentation/screens/details_screen.dart';
import '../../data/country_repository.dart';
import '../widgets/country_list_tile.dart';
import '../widgets/country_search_field.dart';
import '../widgets/pagination_bar.dart';
import '../widgets/region_filter_bar.dart';
import '../widgets/region_picker_sheet.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const int _pageSize = 6;
  static const CountryRepository _repository = CountryRepository();

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _selectedRegion;
  int _page = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Country> get _filteredCountries {
    return _repository.all().where((country) {
      final matchesQuery =
          country.name.toLowerCase().contains(_query.toLowerCase());
      final matchesRegion =
          _selectedRegion == null || country.region == _selectedRegion;
      return matchesQuery && matchesRegion;
    }).toList();
  }

  List<Country> get _pagedCountries {
    final filtered = _filteredCountries;
    final start = _page * _pageSize;
    if (start >= filtered.length) return [];
    final end = (start + _pageSize).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  int get _totalPages {
    final total = _filteredCountries.length;
    if (total == 0) return 1;
    return (total / _pageSize).ceil();
  }

  Future<void> _openRegionPicker() async {
    final region = await RegionPickerSheet.show(
      context,
      regions: _repository.regions(),
      selectedRegion: _selectedRegion,
    );

    if (!mounted) return;
    setState(() {
      _selectedRegion = region;
      _page = 0;
    });
  }

  void _clearRegion() {
    setState(() {
      _selectedRegion = null;
      _page = 0;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _page = 0;
    });
  }

  void _openDetails(Country country) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailsScreen(country: country)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countries = _pagedCountries;

    return Scaffold(
      appBar: const AppTopBar(),
      bottomNavigationBar: const AppBottomNav(currentTab: AppTab.explore),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CountrySearchField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: 12),
                  RegionFilterBar(
                    selectedRegion: _selectedRegion,
                    onOpenPicker: _openRegionPicker,
                    onClear: _clearRegion,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                  clipBehavior: Clip.antiAlias,
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
                                    onTap: () => _openDetails(country),
                                  );
                                },
                              ),
                            ),
                            PaginationBar(
                              page: _page,
                              totalPages: _totalPages,
                              onPrevious: _page > 0
                                  ? () => setState(() => _page--)
                                  : null,
                              onNext: _page < _totalPages - 1
                                  ? () => setState(() => _page++)
                                  : null,
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
