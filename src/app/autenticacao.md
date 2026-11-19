# Autenticação e integração com a API

## 1. Visão geral

A autenticação do World Explorer usa a API Node.js/Express localizada em `../api`. O aplicativo Flutter utiliza `http` para as requisições, `Provider` para compartilhar o estado da sessão e `flutter_secure_storage` para persistir o JWT.

Fluxo implementado:

1. No Drawer lateral direito, o usuário sem sessão encontra **Entrar**.
2. **Entrar** abre a tela de login. Nela existe o link para o cadastro.
3. O cadastro envia `POST /api/register` com `name`, `email` e `password`.
4. O login envia `POST /api/login` com `email` e `password`.
5. A API devolve `accessToken` no JSON e também no cabeçalho `Authorization`. O Flutter salva o token no `flutter_secure_storage`.
6. Depois do login, o app abre automaticamente a tela **Consulta de dados**, que chama `GET /api/me` com `Authorization: Bearer <token>`.
7. A consulta apresenta três atributos retornados pela API: ID, nome e e-mail.
8. Com a sessão ativa, o Drawer exibe `Bem-vindo, {nome}!` no cabeçalho e **Sair** no fim da lista. O logout apaga o JWT e restaura a opção **Entrar**.

## 2. Endpoints da API

| Método | Caminho | Acesso | Finalidade |
|---|---|---|---|
| POST | `/api/register` | Público | Cadastrar usuário |
| POST | `/api/login` | Público | Validar credenciais e emitir JWT |
| GET | `/api/me` | JWT obrigatório | Consultar os dados do usuário autenticado |

Exemplo de resposta de login (campos relevantes):

```json
{
  "message": "OPERAÇÃO BEM SUCEDIDA",
  "accessToken": "<jwt>",
  "tokenType": "Bearer",
  "data": { "id": 1, "name": "Nome", "email": "nome@email.com" }
}
```

O endpoint `/api/me` valida assinatura e expiração do JWT no middleware `authenticateToken.ts`. O token é emitido com validade de 24 horas. A senha nunca é incluída nas respostas; a API armazena seu hash bcrypt.

## 3. Armazenamento: flutter_secure_storage e SharedPreferences

A implementação usa obrigatoriamente `flutter_secure_storage` para gravar, ler e apagar a chave `jwt_access_token`. Esse pacote utiliza mecanismos seguros disponibilizados pelo sistema operacional (Keychain no iOS e armazenamento protegido por Keystore no Android). Assim, o JWT não fica salvo como texto simples em preferências comuns.

`SharedPreferences` é apropriado para dados simples e não sigilosos que precisam persistir entre execuções, por exemplo:

- tema claro/escuro escolhido;
- preferências de idioma ou de interface;
- última região ou pesquisa selecionada;
- opções de exibição.

Ele não é adequado para senhas, credenciais ou JWTs: seu propósito é armazenar preferências, não fornecer um cofre de segredos. Um token roubado pode permitir que outra pessoa utilize a sessão enquanto estiver válido. Por isso, o token é mantido no armazenamento seguro e removido no logout ou quando a API responde `401`.

## 4. HTTPS e proteção em trânsito

HTTPS combina HTTP com TLS. Ele protege a comunicação entre o aplicativo e o servidor por meio de criptografia em trânsito, autenticação do servidor por certificado e mecanismos de integridade. Isso reduz o risco de interceptação, leitura e alteração das credenciais, do JWT e dos dados retornados.

No ambiente de desenvolvimento local, a configuração padrão aponta para `http://10.0.2.2:3000` (emulador Android acessando a máquina host). Para Flutter Web, Linux ou simulador iOS, ajuste a URL para o endereço acessível da API, normalmente `http://localhost:3000` quando executados na mesma máquina. HTTP está habilitado apenas para facilitar testes locais; não transmite os dados criptografados.

Em produção, a API deve ser publicada atrás de um servidor/proxy com certificado TLS válido e o app deve ser compilado com uma URL HTTPS, por exemplo:

```bash
flutter run --dart-define=API_BASE_URL=https://api.seudominio.com
```

Não se deve habilitar exceções para certificados inválidos nem manter `usesCleartextTraffic` liberado em uma versão de produção. O atributo Android incluído neste projeto permite o HTTP local durante o desenvolvimento e deve ser removido/restringido na configuração de release. Também é necessário configurar CORS de acordo com as origens reais, em vez de usar `*` indiscriminadamente.

## 5. Necessidade do pacote Encrypt

**Não foi adicionada uma segunda camada de criptografia com o pacote `encrypt`.** Para este cenário, HTTPS/TLS já criptografa os dados durante o transporte, enquanto `flutter_secure_storage` protege o token persistido no dispositivo. Criptografar manualmente o JSON antes de enviá-lo não substitui TLS e exige que o cliente e o servidor compartilhem e protejam uma chave adicional.

Uma camada adicional pode fazer sentido em requisitos específicos, como criptografia ponta a ponta em que nem mesmo o servidor deve ler determinado conteúdo, ou proteção de dados armazenados em um formato controlado pela aplicação. Nesses casos, é necessário projetar distribuição, rotação, armazenamento e recuperação de chaves.

Vantagens potenciais: confidencialidade adicional para um conteúdo específico, inclusive em cenários nos quais o servidor não deve ter acesso ao texto claro. Desvantagens: maior complexidade, gestão de chaves, risco de implementação incorreta, dificuldade de depuração e pouca vantagem quando o objetivo é apenas proteger requisições comuns já cobertas por TLS. Portanto, para login e consulta de perfil deste projeto, a camada adicional não é necessária.

## 6. Tratamento de falhas

| Cenário | Comportamento |
|---|---|
| Servidor indisponível | Exibe mensagem de falha de conexão |
| Timeout | Requisições têm limite de 12 segundos e exibem aviso |
| Credenciais inválidas | Mensagem de erro enviada pela API é apresentada; login não prossegue |
| Token expirado/inválido (`401`) | API rejeita o token; app apaga o token e redireciona para login |
| JSON inválido/incompatível | Exibe erro de resposta da API em vez de desserializar silenciosamente |
| Falha ao ler/gravar/apagar armazenamento seguro | Exibe mensagem específica de falha no armazenamento |
| Cadastro inválido ou e-mail já utilizado | API retorna erro e o app apresenta a mensagem |

## 7. Configuração e execução

### API

Na pasta `api`, configure `.env` com `API_PORT`, `JWT_SECRET` forte e `DATABASE_URL`. Para SQLite, a configuração local é `DATABASE_URL="file:./dev.db"`. Instale dependências e execute:

```bash
yarn install
npx prisma generate
yarn dev
```

A API fica disponível, por padrão, em `http://localhost:3000`.

### Flutter

Na pasta `app`, instale os pacotes:

```bash
flutter pub get
```

Emulador Android:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

Dispositivo físico: use o IP da máquina que executa a API, na mesma rede, e permita a porta no firewall. Não use `localhost` no aparelho físico para apontar ao computador.

## 8. Principais dificuldades e decisões

- A API inicial tinha login e cadastro, mas não tinha rota protegida de consulta. Foi necessário implementar `GET /api/me` e um middleware para validar o JWT.
- O login original retornava o JWT somente no cabeçalho HTTP. O endpoint foi ajustado para também enviar `accessToken` no JSON, tornando explícito o campo desserializado pelo Flutter.
- O endereço da API varia entre emulador Android, navegador e dispositivo físico. A URL foi centralizada em `ApiConfig` e pode ser sobrescrita com `--dart-define`.
- A navegação precisava preservar o estado das telas existentes. A autenticação foi adicionada em uma área própria (`features/auth`) e o estado de usuário é compartilhado por `Provider`.
- O token deve ser recuperado do armazenamento seguro em cada consulta protegida, não de uma variável em memória ou de `SharedPreferences`.
- O projeto usa HTTP no ambiente local para permitir o teste sem certificado. Essa exceção não representa uma configuração segura de produção: a publicação deve usar HTTPS/TLS.

