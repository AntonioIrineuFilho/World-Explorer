# Responsividade

Foram implementadas adaptações de layout para diferentes larguras de tela, mantendo os dados mockados e o comportamento existente da aplicação.

## Estratégia utilizada

A responsividade foi feita principalmente com `LayoutBuilder`. A partir da largura disponível, as telas alternam entre widgets de layout para telas menores e maiores.

O breakpoint adotado foi:

- **Menor que 700 px:** layout compacto, adequado principalmente a celulares em retrato.
- **700 px ou mais:** layout amplo, adequado a tablets e monitores, incluindo telas em paisagem.

Também foram utilizados `Row`, `Column`, `Expanded`, `Flexible`, `Padding` e `SizedBox` para distribuir o espaço disponível sem depender de dimensões fixas.

## Alterações por arquivo

### `lib/features/explore/presentation/screens/explore_screen.dart`

- Adicionado `LayoutBuilder`.
- A tela alterna entre `ExploreMobileLayout` e `ExploreDesktopLayout`.
- O comportamento de busca, filtro e paginação foi mantido.

### `lib/features/explore/presentation/widgets/explore_responsive_layout.dart`

Novo widget criado para separar os layouts da tela de exploração.

- `ExploreMobileLayout`: mantém os filtros empilhados verticalmente.
- `ExploreDesktopLayout`: limita a largura do conteúdo e coloca campo de busca e filtro de região lado a lado usando `Row`, `Expanded` e `Flexible`.
- A lista ocupa o espaço restante por meio de `Expanded`.
- O card da lista utiliza `DecoratedBox`/`ClipRRect` em vez de um `Container` apenas para decoração.

### `lib/features/favorites/presentation/screens/favorites_screen.dart`

- Adicionado `LayoutBuilder`.
- A tela alterna entre `FavoritesMobileLayout` e `FavoritesDesktopLayout`.

### `lib/features/favorites/presentation/widgets/favorites_responsive_layout.dart`

Novo widget criado para os dois modos de exibição.

- No modo amplo, o conteúdo é limitado a uma largura máxima de 900 px e centralizado.
- No modo compacto, o conteúdo aproveita a largura disponível.
- A lista utiliza `Expanded` para ocupar o espaço vertical restante.

### `lib/features/country_details/presentation/screens/details_screen.dart`

- Adicionado `LayoutBuilder`.
- A tela alterna entre `DetailsMobileLayout` e `DetailsDesktopLayout`.

### `lib/features/country_details/presentation/widgets/details_responsive_layout.dart`

Novo widget criado para os dois modos.

- No modo compacto, as informações e o botão de favoritos ficam empilhados em `Column`.
- No modo amplo, `InfoCard` e o botão de favoritos são posicionados lado a lado em `Row`.
- O conteúdo amplo é centralizado e limitado a 1000 px.

### `lib/features/country_details/presentation/widgets/info_card.dart`

- Adicionado `LayoutBuilder` dentro das linhas de informação.
- Em espaços menores, cada informação permanece empilhada.
- Em espaços maiores, rótulo e valor ficam lado a lado usando `Row`, `SizedBox` e `Expanded`.
- A decoração do card/linhas foi mantida sem usar `Container` exclusivamente como estrutura de layout.

### `lib/shared/widgets/app_top_bar.dart`

- O título foi colocado em `Flexible`.
- `TextOverflow.ellipsis` evita que o título cause overflow em larguras muito pequenas.

## Componentes que já utilizavam layout flexível

Alguns componentes já estavam preparados para diferentes larguras e foram preservados, como:

- `CountryListTile`, que utiliza `Expanded` para o nome do país.
- `FavoriteListTile`, que utiliza `Expanded` para o nome do país.
- `AppBottomNav`, que utiliza `Expanded` para distribuir os itens da navegação.
- `RegionFilterBar`, que utiliza `Flexible` para o chip de região.

## Responsividade — tela de detalhes do país

A tela de detalhes foi ajustada para seguir o mesmo princípio usado na tela de Explorar: em larguras maiores, o conteúdo para de crescer depois de atingir uma largura máxima e permanece centralizado. Em telas menores, ele utiliza a largura disponível com margens laterais.

### Arquivos alterados

- `lib/features/country_details/presentation/screens/details_screen.dart`
- `lib/features/country_details/presentation/widgets/details_body.dart`
- `lib/features/country_details/presentation/widgets/info_card.dart`

### O que foi feito

- `DetailsScreen` passou a usar `LayoutBuilder` para adaptar o espaçamento lateral conforme a largura disponível.
- O conteúdo foi colocado dentro de `Center` + `ConstrainedBox`, com largura máxima de `700 px`. Assim, em telas grandes o card não continua aumentando indefinidamente e fica centralizado.
- Em telas pequenas, o conteúdo continua ocupando o espaço disponível, respeitando as margens laterais.
- O botão de favoritos não acompanha mais a largura total do card. Ele fica alinhado à esquerda do conteúdo e possui largura máxima de `300 px`, evitando ficar excessivamente grande em monitores largos.
- O `InfoCard` continua ocupando toda a largura do conteúdo limitado.
- Cada linha do `InfoCard` agora possui explicitamente `width: double.infinity`, fazendo as linhas divisórias percorrerem toda a largura do card.
- O texto dos rótulos e valores foi centralizado dentro de cada linha, sem alterar a largura das linhas divisórias.
- Foi mantido o `SingleChildScrollView` para evitar overflow quando a altura disponível for pequena, como em janelas baixas ou em modo paisagem.
- O layout continua usando `Column`, `Align`, `ConstrainedBox`, `Padding` e `SizedBox`, evitando `Container` apenas para estruturar o layout.

### Comportamento esperado

- **Tela estreita:** card ocupa praticamente toda a largura disponível; botão ocupa até `300 px`, limitado pelo espaço disponível.
- **Tela larga:** card para em `700 px` e fica centralizado; botão continua com no máximo `300 px` e fica alinhado à esquerda do card.
- **Linhas do card:** percorrem toda a largura interna do card, enquanto os textos permanecem centralizados.
