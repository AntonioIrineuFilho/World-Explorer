/// Modelo simples de país usado para os dados mockados.
class Country {
  final String code; // código único (ex: BR, AR)
  final String flagEmoji; // bandeira em emoji, evita depender de imagens/API
  final String name; // nome comum, exibido nas listas
  final String officialName; // nome oficial, exibido na tela de detalhes
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

  /// População formatada no padrão "203.062.512".
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
