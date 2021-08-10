# language: pt
Funcionalidade: Editar livro

  Cenário: Editar livro com sucesso
    Quando atualizo um livro com a requisição PUT para "/Books" com id "150"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo da requisição enviada
    Então novo livro deve ser listado
