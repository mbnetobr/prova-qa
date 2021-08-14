# language: pt
Funcionalidade: Editar livro

  Cenário: Editar livro com sucesso
    Quando atualizo um livro com a requisição PUT para "/Books" com id "150"
    Então status da resposta deve ser "200"
    E resposta deve conter corpo da requisição enviada
    Então novo livro deve ser listado

  Esquema do Cenário: Não editar livro com valores inválidos na requisição
    Quando tento atualizar um livro com a requisição PUT para "/Books" com <campo> com <valor> com id "150"
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

  Cenario: Não editar livro cujo id não exista
    Quando tento atualizar um livro com a requisição PUT para "/Books" com id inexistente
    Então status da resposta deve ser "404"