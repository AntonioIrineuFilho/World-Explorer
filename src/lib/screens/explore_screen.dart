import 'package:flutter/material.dart';
import '../data/mock_countries.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import 'details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const int _pageSize = 6;

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
    return mockCountries.where((country) {
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
    final region = await showModalBottomSheet<String?>(
      context: context,
      backgroundColor: AppColors.cardWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
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
                trailing: _selectedRegion == null
                    ? const Icon(Icons.check, color: AppColors.primaryBlue)
                    : null,
                onTap: () => Navigator.pop(context, null),
              ),
              ...mockRegions.map(
                (region) => ListTile(
                  title: Text(region),
                  trailing: _selectedRegion == region
                      ? const Icon(Icons.check, color: AppColors.primaryBlue)
                      : null,
                  onTap: () => Navigator.pop(context, region),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    // showModalBottomSheet retorna null tanto se o usuário fechar sem
    // escolher, quanto se escolher "Todas as regiões". Usamos um wrapper
    // para diferenciar os dois casos.
    if (!mounted) return;
    setState(() {
      _selectedRegion = region;
      _page = 0;
    });
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
                  // Campo de busca
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                        _page = 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar país...',
                      hintStyle: const TextStyle(color: Colors.black45),
                      prefixIcon: const Icon(Icons.search, color: Colors.black45),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Botão de filtro por região + chip da região selecionada
                  Row(
                    children: [
                      InkWell(
                        onTap: _openRegionPicker,
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.filter_alt_outlined,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                'Região',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                      if (_selectedRegion != null) ...[
                        const SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.cardWhite,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.primaryBlue),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    _selectedRegion!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRegion = null;
                                      _page = 0;
                                    });
                                  },
                                  child: const Icon(Icons.close,
                                      color: AppColors.primaryBlue, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Lista de países
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
                              style: TextStyle(color: Colors.black54),
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
                                  color: AppColors.divider,
                                ),
                                itemBuilder: (context, index) {
                                  final country = countries[index];
                                  return _CountryTile(
                                    country: country,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => DetailsScreen(
                                              country: country),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            _PaginationBar(
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

class _CountryTile extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const _CountryTile({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(country.flagEmoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  final int page;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const _PaginationBar({
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
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${page + 1} / $totalPages',
            style: const TextStyle(color: Colors.black45, fontSize: 13),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left),
            color: AppColors.primaryBlue,
            disabledColor: Colors.black26,
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right),
            color: AppColors.primaryBlue,
            disabledColor: Colors.black26,
          ),
        ],
      ),
    );
  }
}
