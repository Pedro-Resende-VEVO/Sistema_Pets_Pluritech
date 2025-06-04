# Hotel Pet - PluriTech

Sistema de gerenciamento de hospedagem para pets, desenvolvido em Flutter (frontend) e Node.js/SQLite (backend).

## Descrição

Este sistema permite o cadastro, edição, listagem e remoção de hóspedes (pets) em um hotel para animais. O frontend é uma aplicação Flutter que consome uma API REST desenvolvida em Node.js, que por sua vez utiliza um banco de dados SQLite para persistência dos dados.

### Funcionalidades

- Cadastro de hóspedes (pets) com tutor, espécie, raça, data de entrada e saída prevista.
- Edição e remoção de registros.
- Visualização em tabela dos hóspedes, com cálculo automático dos dias hospedados e previsão de estadia.
- Backend com API RESTful para integração com o frontend.

## Estrutura do Projeto

- `lib/`: Código Flutter (frontend).
- `app/`: Código Node.js (backend) e scripts de banco de dados.

## Pré-requisitos

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/)
- [SQLite3](https://www.sqlite.org/index.html)

## Como executar

### 1. Backend (API Node.js)

1. Instale as dependências:
   ```bash
   cd app
   npm install
   ```
2. Certifique-se de que o arquivo do banco de dados SQLite (`db/database.db`) existe e possui a tabela `Pets`.
3. Inicie o servidor:
   ```bash
   node app/server.js
   - ou -
   npm run dev
   ```
   O servidor estará disponível em `http://localhost:3000/api`.

### 2. Frontend (Flutter)

1. Instale as dependências:
   ```bash
   flutter pub get
   ```
2. Altere o IP da variável `apiHost` em `lib/app.dart` para o IP do seu backend, se necessário.
3. Execute o app:
   ```bash
   flutter run
   ```

## Observações

- Certifique-se de que o backend está acessível pelo IP configurado no frontend.
- O sistema foi desenvolvido para fins didáticos e pode ser expandido conforme a necessidade.

## Licença

MIT
