# language: pt
Funcionalidade: Consultar autor

  Cenário: Buscar autor com sucesso
    Quando que envio a requisição GET para "/Authors" com id "1"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo com dados do autor
    """
    {"id":1,"idBook":1,"firstName":"First Name 1","lastName":"Last Name 1"}
    """
