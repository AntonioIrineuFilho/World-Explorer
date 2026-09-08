# World Explorer — Layout (dados mockados)

Este projeto contém **apenas os layouts** das 3 telas do World Explorer
(Explorar, Detalhes do país e Favoritos), implementados em Flutter,
seguindo os protótipos enviados. Todos os dados de países são **mockados**
(arquivo `lib/data/mock_countries.dart`) — não há integração com a REST
Countries API ainda, conforme solicitado.

## O que já funciona

- Tela **Explorar**: busca por nome, filtro por região (bottom sheet),
  lista de países com paginação simples, navegação para detalhes.
- Tela **Detalhes**: nome oficial, capital, população, moeda e idiomas;
  botão "Adicionar aos favoritos" (alterna para "Remover dos favoritos").
- Tela **Favoritos**: lista dos países favoritados, com botão de remover
  (ícone de lixeira) e navegação para os detalhes.
- Estado de favoritos compartilhado em memória (`FavoritesController`) —
  ainda **não persiste** entre execuções, já que o escopo pediu só o
  layout. Quando for implementar a persistência local (ex:
  `shared_preferences`), basta adaptar esse controller.
- Sem dependência de imagens externas: as bandeiras usam emojis, então o
  projeto roda sem internet.

## Como rodar

1. Extraia a pasta `world_explorer` para o seu computador.
2. Abra um terminal **dentro da pasta do projeto** e rode:
   ```bash
   flutter create .
   ```
   Isso apenas adiciona as pastas nativas (`android/`, `ios/`, etc.) que
   não vêm no zip — ele **não sobrescreve** o `lib/` nem o `pubspec.yaml`
   que já existem.
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Abra a pasta no Android Studio (File > Open) e rode em um emulador ou
   dispositivo físico, ou pelo terminal:
   ```bash
   flutter run
   ```

## Estrutura

```
lib/
├── main.dart
├── models/
│   └── country.dart
├── data/
│   ├── mock_countries.dart       # lista mockada de países
│   └── favorites_controller.dart # estado de favoritos em memória
├── theme/
│   └── app_theme.dart            # cores e estilos globais
├── widgets/
│   ├── app_top_bar.dart          # cabeçalho "World Explorer"
│   └── app_bottom_nav.dart       # barra inferior Explorar/Favoritos
└── screens/
    ├── explore_screen.dart
    ├── details_screen.dart
    └── favorites_screen.dart
```
