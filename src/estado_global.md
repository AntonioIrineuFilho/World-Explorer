# Gerenciamento de estado global

## Abordagem escolhida: Provider + ChangeNotifier

Foi escolhido **Provider + ChangeNotifier** para compartilhar a lista de países favoritos entre as telas Explorar/Detalhes e Favoritos. A implementação é simples, usa o mecanismo de notificação nativo do Flutter e exige pouca configuração adicional.

## Por que Provider, e não Cubit ou MobX?

- **Provider + ChangeNotifier:** integra-se diretamente à árvore de widgets, não exige geração de código e é suficiente para o estado compartilhado deste aplicativo.
- **Cubit:** também separa estado e interface, mas introduziria conceitos e dependências extras (Cubit/Bloc) para uma necessidade simples.
- **MobX:** oferece reatividade, mas a configuração usual exige anotações e geração de código, aumentando o trabalho para este caso.

## O que foi alterado

1. Adicionada a dependência `provider` ao `pubspec.yaml`.
2. Criada a classe `FavoritesStore`, em `lib/features/favorites/data/favorites_controller.dart`, que estende `ChangeNotifier` e mantém a lista de favoritos fora da UI.
3. O `FavoritesStore` é fornecido no topo da aplicação, em `lib/app.dart`, por meio de `ChangeNotifierProvider`. Assim, as rotas e os Navigators internos acessam a mesma instância.
4. `FavoritesScreen` consome o estado com `context.watch<FavoritesStore>()`. A lista é reconstruída quando os favoritos mudam.
5. O botão de favoritos na tela de detalhes consome o estado com `Consumer<FavoritesStore>` e atualiza seu texto/ação quando o país é adicionado ou removido.
6. Ações de adicionar/remover alteram o estado no `FavoritesStore` e chamam `notifyListeners()`, que atualiza os widgets inscritos.

## Dois pontos da UI que compartilham o mesmo estado

- **Tela de detalhes:** o botão indica “Adicionar aos favoritos” ou “Remover dos favoritos” e altera o estado.
- **Tela Favoritos:** a lista mostra os países favoritados e permite removê-los.

Ao favoritar um país nos detalhes, a tela Favoritos reflete a alteração; ao removê-lo da lista, o botão de detalhes também reflete a alteração quando a tela é exibida novamente. Ambos usam a mesma instância de `FavoritesStore`.

## Principal dificuldade encontrada

A principal atenção foi garantir que a instância do estado fosse compartilhada por todas as rotas, incluindo os Navigators aninhados usados pelas abas. Por isso, o `ChangeNotifierProvider` envolve o `MaterialApp`, em vez de ser criado separadamente em cada tela.

## Vantagem percebida sobre `setState`

Com `setState`, seria necessário coordenar manualmente a atualização entre telas ou passar callbacks/dados pela árvore. Com Provider, a lógica fica concentrada em uma classe e cada widget inscrito reage automaticamente às notificações, reduzindo o acoplamento entre a interface e o estado.

## Observação sobre estado local

O estado efêmero da tela Explorar (texto de busca, filtro de região e página atual) continua local, pois só é relevante enquanto essa tela está sendo usada. A refatoração do estado compartilhado foi aplicada aos favoritos, que precisam ser acessíveis em diferentes telas. Portanto, os `setState` restantes da tela Explorar não representam o estado global de favoritos.
