import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/models/country.dart';
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

    _showFeedback(
      region == null
          ? 'Exibindo todas as regiões'
          : 'Região filtrada: $region',
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _clearRegion() {
    setState(() {
      _selectedRegion = null;
      _page = 0;
    });
    _showFeedback('Filtro de região removido');
  }

  void _onSearchChanged(String value) {
    debugPrint('Valor digitado na busca: $value');
    setState(() {
      _query = value;
      _page = 0;
    });
  }

  void _goToPreviousPage() {
    if (_page <= 0) return;
    setState(() => _page--);
    _showFeedback('Página ${_page + 1} carregada');
  }

  void _goToNextPage() {
    if (_page >= _totalPages - 1) return;
    setState(() => _page++);
    _showFeedback('Página ${_page + 1} carregada');
  }

  void _onCountryLongPress(Country country) {
    _showFeedback('País selecionado: ${country.name}');
  }

  void _openDetails(Country country) {
    Navigator.of(context).pushNamed(AppRoutes.details, arguments: country);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    onPrevious: _page > 0 ? _goToPreviousPage : null,
                    onNext: _page < _totalPages - 1 ? _goToNextPage : null,
                    onCountryTap: _openDetails,
                    onCountryLongPress: _onCountryLongPress,
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
                    onPrevious: _page > 0 ? _goToPreviousPage : null,
                    onNext: _page < _totalPages - 1 ? _goToNextPage : null,
                    onCountryTap: _openDetails,
                    onCountryLongPress: _onCountryLongPress,
                  );
          },
        ),
      );
  }
}
