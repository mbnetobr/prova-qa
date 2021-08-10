# language: pt
Funcionalidade: Consultar autor

  Cenário: Buscar autor com sucesso
    Quando envio a requisição GET para "/Authors" com id "1"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo com dados do autor
    """
    {"id":1,"idBook":1,"firstName":"First Name 1","lastName":"Last Name 1"}
    """

  Cenario: Listar todas os autores com sucesso
    Quando envio a requisição GET para "/Authors"
    Então status da resposta deve ser "200"
    E resposta deve conter lista de autores com os campos preenchidos

  Cenario: Buscar autor por livro com sucesso
    Quando envio a requisição GET para "/Authors/authors/books" com id "1"
    Então status da resposta deve ser "200"
    E resposta deve conter lista com 4 autores
    """
    [{"id":1,"idBook":1,"firstName":"First Name 1","lastName":"Last Name 1"},
     {"id":2,"idBook":1,"firstName":"First Name 2","lastName":"Last Name 2"},
     {"id":3,"idBook":1,"firstName":"First Name 3","lastName":"Last Name 3"},
     {"id":4,"idBook":1,"firstName":"First Name 4","lastName":"Last Name 4"}]
    """

  Cenario: Não buscar autor cujo id não exista
    Quando envio a requisição GET para "/Authors" com id inexistente
    Então status da resposta deve ser "404"

  Cenario: Validar consistência nas respostas da consulta do mesmo autor
    Dado que tenho o autor
    """
    {"id":590,"idBook":195,"firstName":"First Name 590","lastName":"Last Name 590"}
    """
    Quando envio "10" vezes a requisição GET para "/Authors" com id "590"
    Então resposta deve conter corpo com dados do autor requisitado