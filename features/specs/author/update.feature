# language: pt
Funcionalidade: Editar autor

  Cenário: Editar autor com sucesso
    Quando que envio a requisição PUT para "/Authors" com id "595"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo da requisição enviada
    Então novo autor deve ser listado
