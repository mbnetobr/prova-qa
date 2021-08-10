# language: pt
Funcionalidade: Cadastrar autor

  Cenário: Cadastrar autor com sucesso
    Quando que envio a requisição POST para "/Authors"
    Então status da resposta deve ser "201"
    E resposta deve conter corpo da requisição enviada
    Então novo autor deve ser listado