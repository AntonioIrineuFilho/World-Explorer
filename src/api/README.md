# API Word Explorer

API desenvolvida com Node e Express, utilizando Prisma como ORM e SQLite como banco de dados.

## Pré-Requisitos

- Node 20 ou superior
- Yarn 4.18.1

## Como executar localmente

**1. Baixe as dependências executando ```yarn install``` na pasta raiz da API**

**2. Crie o ```.env``` preenchendo as variáveis de ambiente:**

```
API_PORT -> Se não preencher utiliza 3000 como fallback

JWT_SECRET -> Gere um segredo utilizando o código no .env.example

DATABASE_URL -> Para SQLite utilizar "file:./dev.db", para outros bancos configurar connection string e baixar o adapter do Prisma para o banco em questão 
```

**3. Gere a primeira migração e o prisma client:**

```
npx prisma migrate dev --name init

npx prisma generate
```

**4. Execute o serviço da API**:

- ```yarn dev``` -> Subir localmente sem compilar e com hot reload
- ```yarn build``` -> Gerar um artefato compilado do projeto na pasta dist
- ```yarn start``` -> Subir o build gerado