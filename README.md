# World Explorer

## Visão geral

O World Explorer será uma aplicação mobile desenvolvida em Dart/Flutter para consulta e exploração de informações sobre países do mundo.

A aplicação terá como principal fonte de dados uma API pública externa. Os dados obtidos serão apresentados de forma simples e organizada, permitindo ao usuário pesquisar países, filtrá-los por região, consultar seus detalhes e salvar países como favoritos.

A aplicação será composta por três telas principais: Explorar, Detalhes do país e Favoritos.

## Objetivo

- Consumo de uma API REST externa
- Conversão e utilização de dados JSON
- Navegação entre telas
- Exibição de listas e informações detalhadas
- Pesquisa e filtragem de dados
- Persistência de dados localmente

## Funcionalidades

### Tela Explorar

Será a tela principal da aplicação.

O usuário poderá:

- Visualizar uma lista de países
- Pesquisar um país pelo nome
- Filtrar os países por região
- Selecionar um país para visualizar seus detalhes
- Navegar para a tela de favoritos

### Tela de Detalhes

Ao selecionar um país, o usuário será direcionado para uma tela contendo informações detalhadas, como:

- Bandeira
- Nome oficial
- Capital
- População
- Moeda
- Idiomas

Nessa tela também será possível adicionar o país aos favoritos.

### Tela de Favoritos

A tela de favoritos apresentará os países que foram salvos pelo usuário.

O usuário poderá:

- Visualizar os países favoritados
- Selecionar um país para consultar seus detalhes
- Remover um país dos favoritos

Os favoritos deverão permanecer salvos mesmo após o encerramento e reabertura da aplicação.

### Integração com API externa

A aplicação utilizará uma API pública de informações sobre países, como a **REST Countries API**, para obter os dados apresentados ao usuário.

A API será responsável por fornecer informações como nome, bandeira, capital, população, moedas, idiomas e regiões.

### Persistência local

A aplicação utilizará armazenamento local do dispositivo exclusivamente para persistir os países marcados como favoritos.

Ao abrir a tela de favoritos, os dados armazenados localmente serão recuperados e apresentados ao usuário.

A persistência local terá como objetivo demonstrar que a aplicação consegue manter informações entre diferentes sessões de uso, sem depender de um servidor próprio.

Os dados gerais dos países não serão necessariamente armazenados localmente. A API continuará sendo a fonte principal dessas informações; o armazenamento local será utilizado para os favoritos.

## Conclusão 

Ao final do desenvolvimento, espera-se uma aplicação mobile funcional na qual o usuário consiga explorar países, pesquisar e filtrá-los, visualizar informações detalhadas e manter uma lista de favoritos persistida localmente.

O projeto deverá demonstrar, de maneira simples e objetiva, a integração entre uma aplicação Flutter, uma API REST externa e um mecanismo de persistência de dados local.
