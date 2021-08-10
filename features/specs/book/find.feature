# language: pt
Funcionalidade: Consultar livro

  Cenário: Buscar livro com sucesso
    Quando pesquiso um livro com a requisição GET para "/Books" com id "1"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo com dados do livro