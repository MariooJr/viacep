# ViaCep

Exemplo em Visual FoxPro de utilização do web service https://viacep.com.br/ws/ disponível para pesquisa de CEPs.

No exemplo, foi criada uma rotina que recebe o CEP como parâmetro, realiza a pesquisa e obtêm o retorno do serviço.
Pode ser usado com qualquer versão do Visual FoxPro.

Qualquer dúvida/sugestão, por favor, entre em contato.


# Exemplo de uso

```
oCep = CREATEOBJECT("buscarCep")

*Chama o metodo para pesquisar o cep
oCep.pesquisar("15130682")

*Caso a propriedade mensagem esteja vazia, então a consulta foi realizada com sucesso
IF EMPTY(ALLTRIM(oCep.mensagem))
   ?oCep.cep
   ?oCep.logradouro
   ?oCep.bairro
   ?oCep.localidade
   ?oCep.uf
   ?oCep.ibge
   ?oCep.ddd
   ?oCep.gia
   ?oCep.siafi
ENDIF 
oCep = null
```
