class Country {
  final String code;
  final String flagEmoji;
  final String name;
  final String officialName;
  final String capital;
  final int population;
  final String currency;
  final List<String> languages;
  final String region;

  const Country({
    required this.code,
    required this.flagEmoji,
    required this.name,
    required this.officialName,
    required this.capital,
    required this.population,
    required this.currency,
    required this.languages,
    required this.region,
  });

  String get populationFormatted {
    final str = population.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromEnd = str.length - i;
      buffer.write(str[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }

  String get languagesFormatted => languages.join(', ');
}
