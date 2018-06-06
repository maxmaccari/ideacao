# Ideacao

## Objetivos Gerais
Permitir uma equipe compartilhar e avaliar ideias em conjunto.

## Objetivos Especificos
  * Indivíduos compartilhar ideias específicas, informando o seu público alvo, seu problema e outras informações;
  * Usuários dar feedback e avaliar as ideias;
  * Equipe selecionar uma ideia para se trabalhar em cima dela;
  * Equipe poder validar e melhorar as suas ideias;
  * Equipe poder trabalhar em uma ideia utilizando as metodologias Lean Startup, outras relacionadas a UX ou Lean.

## Objetivos Técnicos
  * Criar um aplicativo usando Elixir e Phoenix como API;
  * Criar o front end do aplicativo usando VueJS dentro do próprio Phoenix;
  * Adicionar recursos realtime no aplicativo para ser utilizado de forma colaborativa;
  * Aprender a testar APIs no Backend;
  * Aprender a testar aplicações Vue no Front End.

## Roadmap
  * Gerar o projeto Phoenix [concluído];
  * Idealizar e criar os modelos e estrutura de dados inicial do projeto [concluído];
  * Criar os Endpoints da API que irão expor os dados (cobertos por testes) [concluído];
  * Adicionar uma camada segurança na aplicação através de autenticação de usuário [concluído];
  * Instalar o VueJS e o Vuetify;
  * Idealizar e criar as telas que consumirão a API do projeto;

### Modelos Futuros
  ```
  Team
    - name : String
    - logo : String

  Membership
    - user : User
    - team : Team
    - role : String

  Revision
    - user : User
    - idea : Idea
    - revision_number : Integer
    - relevancy_rate : Integer
    - relevancy_description : Text
    - market_rate : Integer
    - market_description : Text
    - target_revision : Text
    - problem_revision : Text
    - description_revision : Text

  Comment
    - user : User
    - idea : Idea
    - content : Text
  ```

## Roadmap Secundário
  * Cada ideia deverá ser relacionada a uma equipe;
  * Adicionar funcionalidade de criação de equipes, registro de usuário, convites de usuário e recuperação de senha;
  * Adicionar testes para o Front End;
  * Pensar em recursos legais para usar em startups;
  * Reescrever o readme em inglês.

## Instructions
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
