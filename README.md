# Prova QA

Este desafio tem o intuito de avaliar suas habilidades em testes automatizados e manuais.

## Descrição Geral

- https://fakerestapi.azurewebsites.net/index.html

- No link acima temos o Swagger de uma API pública de Livros.

- Este serviço é composto de cinco collections: Atividades, Autores, Livros, Fotos de Capa e Usuários.

- Com algumas requisições podemos adcionar, editar, pesquisar ou remover registros.

## O que sua prova deve conter

1. Escolha duas dentre as collections da API de Livros. (**Exceto as coleções de usuários e atividades**)

2. Construa na Ferramenta Postman as requisições para as collections escolhidas

3. Elabore um projeto de Testes Automatizados de API com o **Framework e Linguagem de sua preferência**

Você deve abrir uma Pull Request para [este repositório](https://github.com/mbnetobr/prova-qa), contendo os itens a seguir:

- Arquivo no fromato Json exportado do Postman contendo as requisições.

- Projeto de Testes Automatizados contendo uma suíte de testes de API.

- Instruções de como executar o projeto.

## Instruções de entrega

1. Primeiro, faça um fork deste projeto para sua conta no Github.
 
2. Em seguida, implemente sua solução seguindo as instruções que estão acima.

3. Envie o link do seu Pull Request, com a resultado da prova, para manuel.neto@trademaster.com.br com cópia para seu headhunter.

## Pontos de Atenção

1. Tenha atenção para a qualidade e complexidade do projeto que você está montando.

2. Não fique em cenários comuns de teste, valide erros, fluxo de exceção e relações entre as coleções.

3. Foque em construir um projeto simples mais bem elaborado, utilize algum padrão de projeto, gere relatórios, reutilize código etc.

4. Mostre que você é **Sênior**, se ainda não é, mostre que pode se tornar.

5. Qualquer dúvida não exite em entrar em contato: manuel.neto@trademaster.com.br

---

## Automação FakeRESTApi.Web V1

  Projeto para validar a [FakeRESTApi.Web V1](https://fakerestapi.azurewebsites.net/index.html) de forma automatizada, o qual utiliza as seguintes ferramentas:

  - **[Ruby](https://www.ruby-lang.org/en/)**;
  - **[Cucumber](https://cucumber.io)** para escrita **[Gherkin](https://cucumber.io/docs/gherkin/reference/)**;
  - **[HTTParty](https://github.com/jnunemaker/httparty)**;
  - **[RSpec](https://github.com/rspec/rspec)**.

## Pré-requisito: 

  - [Ruby](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04-pt) instalado. (**OBS.** Neste projeto foi usada a versão 2.6.1 do ruby).

### Instalando gemas do Ruby

  - A partir da pasta de seu projeto, execute no terminal o comando: `bundle`.

### Configuração do ambiente

  - **OBS.** Para este desafio não é necessário seguir os próximos passos desta etapa de configuração, pois o arquivo `.env` já está preenchido. Contudo, caso esse projeto estivesse validando dados reais de uma organização, os valores de variáveis de ambiente e demais conteúdos que exigem privacidade da equipe responsável, a recomendação seria seguir as próximas etapas desta secção de modo a manter seguros os dados sensíveis do projeto, além de adicionar o arquivo `.env` dentro do `.gitignore`.
  - Duplique o arquivo `.env.sample` e o renomeie para `.env`;
  - Consulte o(s) QA(s) do time, o(s) qual(is) mantém este projeto para obter os valores das chaves para preencher o arquivo `.env` criado no passo anterior.

### Execução

  - Para visualizar o resultado de todos os testes e gerar seu relatório em **.html** executar no terminal a partir da pasta raiz do projeto o comando: `cucumber -p default`.

  - Reports disponíveis em: **/report**, para visualizá-lo abra o arquivo `report.html` em um navegador de sua preferência.

---

## Testes Manuais com Postman

  Projeto para testar a [FakeRESTApi.Web V1](https://fakerestapi.azurewebsites.net/index.html) de forma manual, o qual utiliza o [Postman](https://www.postman.com) como ferramenta de validações

  [Postman](https://www.postman.com/downloads)

## Pré-requisito: 

  - [Postman](https://www.postman.com/downloads) instalado.

## Configuração do ambiente

### Importando o projeto

  - Com a aplicação do Postman aberta clique em: **File > Import**
  - Na aba **File**, clique no botão **Upload Files** e navegue até a pasta do projeto de automação **prova-qa > postman** e selecione o arquivo com a coleção de requisições (`requests_fake_rest_api_v1.postman_collection.json`) e clique no botão **Import**;
  - Repita o processo clicando em: **File > Import**
  - Na aba **File**, clique no botão **Upload Files** e navegue até a pasta do projeto de automação **prova-qa > postman** e agora selecione o arquivo com as variáveis de ambiente (`environment_variables_fake_rest_api_v1.postman_environment.json`) e clique no botão **Import**;

### Execução

  - Com a aplicação do Postman aberta navegue até a aba **Collections > FakeRESTApi.V1**
  - Agora basta selecionar dentro das pastas: **Autores** ou **Livros**, a requisição que deseja testar e clicar no botão **Send**