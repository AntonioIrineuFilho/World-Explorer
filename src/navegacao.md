# Navegação

## O que já existia

Antes das alterações, o aplicativo já possuía navegação básica entre **Explorar**, **Favoritos** e a tela de detalhes. A implementação foi reorganizada para atender aos requisitos de navegação sem adicionar funcionalidades que não fazem parte do fluxo desejado.

- o `BottomNavigationBar` tinha apenas Explorar e Favoritos;
- a troca de abas usava `pushNamedAndRemoveUntil`, portanto não preservava uma pilha independente para cada aba;
- as telas possuíam seus próprios `AppTopBar` e `AppBottomNav`;
- não havia Drawer;
- a navegação para detalhes usava `MaterialPageRoute` diretamente, sem uma rota nomeada centralizada.

## Alterações realizadas

### 1. Navegação principal

Foi criado o `AppShell`, responsável por concentrar:

- `Drawer`;
- `BottomNavigationBar` personalizado;
- `IndexedStack`;
- um `Navigator` independente para cada aba.

As abas do BottomNavigationBar permanecem **somente**:

1. Explorar
2. Favoritos

Cada uma possui sua própria `GlobalKey<NavigatorState>`, preservando o histórico de navegação enquanto o usuário alterna entre as abas.

### 2. Drawer

O Drawer possui somente:

- **Configurações** — utiliza `Navigator.pushNamed` para abrir a tela de configurações;
- **Sobre** — abre um `AlertDialog`.

A tela de configurações retorna um resultado com `Navigator.pop(context, true)`, que é recebido pelo `AppShell` e gera uma confirmação por `SnackBar`.

### 3. Rotas nomeadas

As rotas foram centralizadas em `AppRoutes` e processadas por `AppRouteBuilder`.

A rota `/details` recebe um objeto `Country` através de `arguments`:

```dart
Navigator.of(context).pushNamed(
  AppRoutes.details,
  arguments: country,
);
```

A rota recupera o argumento e cria a `DetailsScreen`.

### 4. Botão voltar

O `AppShell` controla o botão voltar do sistema:

- se a aba atual possui histórico, o histórico local é desfeito;
- se estiver na aba Favoritos sem histórico, o retorno vai para Explorar;
- estando em Explorar sem histórico, o comportamento padrão do sistema é mantido.

## Arquivos principais alterados/criados

- `lib/app.dart`
- `lib/core/constants/app_routes.dart`
- `lib/core/navigation/app_route_builder.dart`
- `lib/features/navigation/presentation/screens/app_shell.dart`
- `lib/features/navigation/presentation/screens/settings_screen.dart`
- `lib/features/explore/presentation/screens/explore_screen.dart`
- `lib/features/favorites/presentation/screens/favorites_screen.dart`
- `lib/features/country_details/presentation/screens/details_screen.dart`
- `lib/shared/widgets/app_bottom_nav.dart`
- `lib/shared/widgets/app_top_bar.dart`
