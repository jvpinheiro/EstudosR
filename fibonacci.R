# Declara fun��o para retornar sequ�ncia de Fibonacci
Fibonacci <- function(tamanho = NA){

  ## Tratamento de exce��o (caso venha um par�metro inv�lido)

  # Se n�o informou par�metro
  if (is.na(tamanho)){
    # Exibe mensagem de alerta de erro de par�metro
    return("N�o foi informado n�mero!")
  # Se informou par�metro inv�lido
  } else if (!is.numeric(tamanho)){
    # Exibe mensagem de alerta de erro de par�metro
    return("Par�metro inv�lido!")
  }

  ## Processa funcao
  if (tamanho == 1)
  {
    sequencia <- 1
  } else {
    sequencia <- c(1,1)
  }
  
  # soma os dois anteriores pra conseguir o termo seguinte
  if (tamanho > 2)
  {
    for (i in 1:(tamanho-2))
    {
      soma <- sequencia[i] + sequencia[i+1]
      sequencia[i+2] <- soma
    }
  }
  
  print(sequencia)
}

Fibonacci(12)
