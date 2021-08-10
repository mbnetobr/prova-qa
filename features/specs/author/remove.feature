# language: pt
Funcionalidade: Remover autor

  Cenário: Remover autor com sucesso
    Dado que tenho um autor cadastrado
    Quando envio a requisição DELETE para "/Authors" com o id do autor
    Então status da resposta deve ser "204"
    E consulta não deve exibir o autor excluído
