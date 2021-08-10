# language: pt
Funcionalidade: Consultar livro

  Cenário: Buscar livro com sucesso
    Quando pesquiso um livro com a requisição GET para "/Books" com id "1"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo com dados do livro

  Cenario: Listar todas os livros com sucesso
    Quando pesquiso todos os livros com a requisição GET para "/Books"
    Então status da resposta deve ser "200"
    E resposta deve conter lista de livros com os campos preenchidos

  Cenario: Não buscar livro cujo id não exista
    Quando tento pesquisar livro com a requisição GET para "/Books" com id inexistente
    Então status da resposta deve ser "404"