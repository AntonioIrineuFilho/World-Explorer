import 'package:flutter/material.dart';
import '../../../../shared/models/country.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../country_details/presentation/screens/details_screen.dart';
import '../../data/country_repository.dart';
import '../widgets/explore_responsive_layout.dart';
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
    return Scaffold(
      appBar: const AppTopBar(),
      bottomNavigationBar: const AppBottomNav(currentTab: AppTab.explore),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;
            return isWide
                ? ExploreDesktopLayout(
                    searchController: _searchController,
                    onSearchChanged: _onSearchChanged,
                    selectedRegion: _selectedRegion,
                    onOpenRegionPicker: _openRegionPicker,
                    onClearRegion: _clearRegion,
                    countries: _pagedCountries,
                    page: _page,
                    totalPages: _totalPages,
                    onPrevious: _page > 0
                        ? () => setState(() => _page--)
                        : null,
                    onNext: _page < _totalPages - 1
                        ? () => setState(() => _page++)
                        : null,
                    onCountryTap: _openDetails,
                  )
                : ExploreMobileLayout(
                    searchController: _searchController,
                    onSearchChanged: _onSearchChanged,
                    selectedRegion: _selectedRegion,
                    onOpenRegionPicker: _openRegionPicker,
                    onClearRegion: _clearRegion,
                    countries: _pagedCountries,
                    page: _page,
                    totalPages: _totalPages,
                    onPrevious: _page > 0
                        ? () => setState(() => _page--)
                        : null,
                    onNext: _page < _totalPages - 1
                        ? () => setState(() => _page++)
                        : null,
                    onCountryTap: _openDetails,
                  );
          },
        ),
      ),
    );
  }
}
