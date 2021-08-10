# language: pt
Funcionalidade: Editar autor

  Cenário: Editar autor com sucesso
    Quando que envio a requisição PUT para "/Authors" com id "595"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo da requisição enviada
    Então novo autor deve ser listado

  Esquema do Cenário: Não editar autor com valores inválidos na requisição
    Quando envio a requisição PUT para "/Authors" com <campo> com <valor> com id "595"
    Então status da resposta deve ser "400"
    Exemplos:
    | campo       | valor  |
    | 'id'        | ''     |
    | 'id'        | 'abc'  |
    | 'id'        | '595'  |
    | 'idBook'    | ''     |
    | 'idBook'    | 'abc'  |
    | 'idBook'    | '100'  |
    | 'firstName' | '123'  |
    | 'firstName' | 'true' |
    | 'lastName'  | '123'  |
    | 'lastName'  | 'true' |
 
  Cenario: Não editar autor cujo id não exista
    Quando envio a requisição PUT para "/Authors" com id inexistente
    Então status da resposta deve ser "404"