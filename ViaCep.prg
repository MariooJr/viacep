***************
DEFINE CLASS ViaCep as Custom
   *Inicializa a classe e adiciona as propriedaes
   PROCEDURE init
      this.AddProperty("mensagem","")
      this.AddProperty("cep","")
      this.AddProperty("logradouro","")
      this.AddProperty("bairro","")
      this.AddProperty("localidade","")
      this.AddProperty("uf","")
      this.AddProperty("ibge","")
      this.AddProperty("ddd","")
      this.AddProperty("gia","")
      this.AddProperty("siafi","")
   ENDPROC 

    
   PROCEDURE pesquisar
   LPARAMETERS nCep
   
	   IF EMPTY(ALLTRIM(nCep))
	      oCep.mensagem = "CEP INVALIDO"
	      RETURN 0
	   ENDIF
	    
	   numeroCep = STRTRAN(nCep,"-","")
	   numeroCep = STRTRAN(nCep,".","")
	   
	   apiUrl = "https://viacep.com.br/ws/" + numeroCep + "/xml/"
	   
	   httpRequest = CREATEOBJECT("WinHttp.WinHttpRequest.5.1")
	   httpRequest.Open("GET", apiUrl , .F.)
	   httpRequest.SetRequestHeader("Content-Type", "application/xml")
	   httpRequest.SetRequestHeader("Accept-Charset", "utf-8")
	   httpRequest.send()
	   
	   IF !EMPTY(ALLTRIM(httpRequest.responsebody))
	   	  &&Converte o retorno para UTF-8 para não dar problema nos acentos.
	   	  retorno = STRCONV(httpRequest.responsebody,11)
	   	  
	      msgErro = STREXTRACT(retorno, "<erro>","</erro>")
	      IF !EMPTY(ALLTRIM(msgErro))
	         this.mensagem = "CEP inválido ou inexistente"
	         RETURN 0
	      ENDIF 
	      
	      this.mensagem    = ""
	      this.cep         = UPPER(STREXTRACT(retorno, "<cep>","</cep"))
	      this.logradouro  = UPPER(STREXTRACT(retorno, "<logradouro>","</logradouro>"))
	      this.bairro      = UPPER(STREXTRACT(retorno, "<bairro>","</bairro>"))
	      this.localidade  = UPPER(STREXTRACT(retorno, "<localidade>","</localidade"))
	      this.uf          = UPPER(STREXTRACT(retorno, "<bairro>","</bairro>"))
	      this.ibge        = UPPER(STREXTRACT(retorno, "<ibge>","</ibge>"))
	      this.ddd         = UPPER(STREXTRACT(retorno, "<ddd>","</ddd>"))
	      this.gia         = UPPER(STREXTRACT(retorno, "<gia>","</gia>"))
	      this.siafi       = UPPER(STREXTRACT(retorno, "<siafi>","</siafi>"))
	      
	   ENDIF 
   ENDPROC  
   
ENDDEFINE
