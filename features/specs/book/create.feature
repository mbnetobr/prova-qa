# language: pt
Funcionalidade: Cadastrar livro

  Cenário: Cadastrar livro com sucesso
    Quando cadastro um livro com a requisição POST para "/Books"
    Então status da resposta deve ser "201"  
    E resposta deve conter corpo da requisição enviada
    Então novo livro deve ser listado

  Esquema do Cenário: Não cadastrar livro com valores inválidos na requisição
    Quando cadastro um livro com a requisição POST para "/Books" com <campo> com <valor>
    Então status da resposta deve ser "400"
    Exemplos:
    | campo         | valor                    |
    | 'id'          | ''                       |
    | 'id'          | 'abc'                    |
    | 'id'          | 'true'                   |
    | 'id'          | '595'                    |
    | 'title'       | ''                       |
    | 'title'       | '123'                    |
    | 'title'       | 'true'                   |
    | 'description' | ''                       |
    | 'description' | 'true'                   |
    | 'description' | '123'                    |
    | 'pageCount'   | ''                       |
    | 'pageCount'   | 'abc'                    |
    | 'pageCount'   | 'true'                   |
    | 'pageCount'   | '595'                    |
    | 'excerpt'     | ''                       |
    | 'excerpt'     | '123'                    |
    | 'excerpt'     | 'true'                   |
    | 'publishDate' | ''                       |
    | 'publishDate' | '2011-31-12T00:00:00.00' |
    | 'publishDate' | '31-12-2000T00:00:00.00' |
    | 'publishDate' | '12-31-2000T00:00:00.00' |
    | 'publishDate' | '123'                    |
    | 'publishDate' | 'true'                   |