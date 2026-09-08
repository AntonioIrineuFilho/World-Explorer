# Documentação do código

Por enquanto, apenas os layouts das 3 telas do World Explorer (Explorar, Detalhes do país e Favoritos) forma implementados. Todos os dados de países são **mockados**  (`lib/features/explore/data/country_repository.dart`), não havendo integração com a REST Countries API ainda.

## O que já funciona

- Tela **Explorar**: busca por nome, filtro por região (bottom sheet), lista de países com paginação simples, navegação para detalhes
- Tela **Detalhes**: nome oficial, capital, população, moeda e idiomas; botão "Adicionar aos favoritos" (alterna para "Remover dos favoritos")
- Tela **Favoritos**: lista dos países favoritados, com botão de remover (ícone de lixeira) e navegação para os detalhes
- Estado de favoritos compartilhado em memória (`FavoritesController`) (ainda **não persiste** entre execuções). Quando for implementar a persistência local, basta adaptar esse controller

## Como rodar

- Rode ```flutter create .``` na raiz do projeto (adiciona as pastas nativas `android/`, `ios/`, etc.)
- Rode ```flutter pub get``` para baixar as dependências
- Rode ```flutter run``` para executar o projeto (Android Studio ou terminal)

## Arquitetura feature-first

O código é organizado por **feature** (funcionalidade de negócio), não por tipo de arquivo. Cada feature carrega seus próprios dados e apresentação; o que é realmente compartilhado entre features fica isolado em `core/` e `shared/`.
