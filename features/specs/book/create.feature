# language: pt
Funcionalidade: Cadastrar livro

  Cenário: Cadastrar livro com sucesso
    Quando cadastro um livro com a requisição POST para "/Books"
    Então status da resposta deve ser "201"  
    E resposta deve conter corpo da requisição enviada
    Então novo livro deve ser listado
