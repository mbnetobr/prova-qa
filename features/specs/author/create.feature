# language: pt
Funcionalidade: Cadastrar autor

  Cenário: Cadastrar autor com sucesso
    Quando que envio a requisição POST para "/Authors"
    Então status da resposta deve ser "201"
    E resposta deve conter corpo da requisição enviada
    Então novo autor deve ser listado

  Esquema do Cenário: Não cadastrar autor com valores inválidos na requisição
    Quando envio a requisição POST para "/Authors" com <campo> com <valor>
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

  Cenário: Não cadastrar autor cujo id já esteja inserido na base
    Dado que tenho um autor cadastrado
    Quando que envio a requisição POST para "/Authors" com id do autor cadastrado
    Então status da resposta deve ser "409"
