# Declara função para retornar sequência de Fibonacci
Fibonacci <- function(tamanho = NA){

  ## Tratamento de exceção (caso venha um parâmetro inválido)

  # Se não informou parâmetro
  if (is.na(tamanho)){
    # Exibe mensagem de alerta de erro de parâmetro
    return("Não foi informado número!")
  # Se informou parâmetro inválido
  } else if (!is.numeric(tamanho)){
    # Exibe mensagem de alerta de erro de parâmetro
    return("Parâmetro inválido!")
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
