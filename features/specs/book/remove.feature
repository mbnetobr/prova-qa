# language: pt
Funcionalidade: Remover livro

  Cenário: Remover livro com sucesso
    Dado que tenho um livro cadastrado
    Quando excluo um livro com a requisição DELETE para "/Books" com o id do livro
    Então status da resposta deve ser "204"
    E consulta não deve exibir o livro excluído
