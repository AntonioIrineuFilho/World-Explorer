# World Explorer

Por enquanto, apenas os layouts das 3 telas do World Explorer
(Explorar, Detalhes do país e Favoritos), implementados em Flutter,
seguindo os protótipos enviados. Todos os dados de países são **mockados**
(`lib/features/explore/data/country_repository.dart`), não havendo integração
com a REST Countries API ainda.

## O que já funciona

- Tela **Explorar**: busca por nome, filtro por região (bottom sheet),
  lista de países com paginação simples, navegação para detalhes
- Tela **Detalhes**: nome oficial, capital, população, moeda e idiomas;
  botão "Adicionar aos favoritos" (alterna para "Remover dos favoritos")
- Tela **Favoritos**: lista dos países favoritados, com botão de remover
  (ícone de lixeira) e navegação para os detalhes
- Estado de favoritos compartilhado em memória (`FavoritesController`) —
  ainda **não persiste** entre execuções. Quando for implementar a
  persistência local (ex: `shared_preferences`), basta adaptar esse
  controller
- Ícones do protótipo (Figma) em `assets/icons/` e `assets/flags/`,
  usados no lugar dos ícones padrão do Material
- Tipografia **Inter** (fonte variável, embutida em `assets/fonts/` —
  não depende de internet para exibir a fonte)

## Como rodar

- Rode ```flutter create .``` na raiz do projeto (adiciona as pastas nativas `android/`, `ios/`, etc.)
- Rode ```flutter pub get``` para baixar as dependências
- Rode ```flutter run``` para executar o projeto (Android Studio ou terminal)

## Arquitetura — feature-first

O código é organizado por **feature** (funcionalidade de negócio), não por
tipo de arquivo. Cada feature carrega seus próprios dados e apresentação;
o que é realmente compartilhado entre features fica isolado em `core/` e
`shared/`

Regra de dependência: uma feature nunca importa arquivos de dentro de
outra feature "irmã" para reaproveitar widgets internos — o
`AppBottomNav`, por exemplo, navega por **rota nomeada**
(`AppRoutes.explore` / `AppRoutes.favorites`) em vez de importar
`ExploreScreen`/`FavoritesScreen` diretamente, para não acoplar
`shared/` às telas de cada feature. `country_details` e `favorites`
importam a tela uma da outra apenas para navegar ao tocar em um país da
lista (`Navigator.push` direto), o que é aceitável em apps pequenos; num
projeto maior isso normalmente vira uma rota nomeada também.
