# Indica se o cliente é VIP
clienteVIP <- TRUE

# Limite de crédito
limiteCredito <- 1500

# Saldo atual
saldoAtual <- 1100

# Saldo atual
limiteEmprestimo <- saldoAtual + limiteCredito

# Valor do emprestimo solicitado
emprestimoSolicitado <- 5000

# Se o credito solicitado supera o limite de crédito
if (emprestimoSolicitado > limiteEmprestimo){
  print("Emprestimo negado!")
}

# Se o credito solicitado NÃO supera o limite de crédito
if (!(emprestimoSolicitado > limiteEmprestimo)){  
  print("Emprestimo aprovado!")
} else {   
  print("Emprestimo negado!")
}

# Se limite de crédito for menor ou igual ao empréstimo solicitado
if (limiteEmprestimo <= emprestimoSolicitado){
  print("Emprestimo negado!")
} else { 
  print("Emprestimo aprovado!")
}

# Se limite de crédito for menor ou igual ao empréstimo solicitado e NÃO for cliente VIP
if ((limiteEmprestimo <= emprestimoSolicitado) & !clienteVIP){  
  print("Emprestimo negado!")
} else {
  print("Emprestimo aprovado!")
}

# Indica que o cliente é do grupo Comercial
codGrupoCliente <- 2

# Exibe o nome do grupo do cliente
if(codGrupoCliente == 1){
  print("Cliente VIP")
} else if(codGrupoCliente == 2){
  print("Cliente Comercial")
} else if(codGrupoCliente == 3){
  print("Cliente Industrial")
} else {
  print("Outro")
}

# Cria um vetor de valores
(vetorValores <- c(100, 15, 23, 23.54))

# Retorna valores pares ou ímpares
ifelse(
  test = vetorValores %% 2 == 0, 
  yes = "par", 
  no = "ímpar"
)

# Cria vetor de nome de países
paises <- c("Brasil", "Alemanha", "Dinamarca", "Camboja")

# Varre os paises do vetor exibindo nome a nome 
for (pais in paises){
  # Exibe o país
  print(pais)
}

# Varre os paises do vetor exibindo nome a nome 
for (pais in c("Brasil", "Alemanha", "Dinamarca", "Camboja")){
  # Exibe o país
  print(pais)
}


# Cria vetor de nome de países
paises <- c("Brasil", "Alemanha", "Dinamarca", "Camboja")

# Varre os paises do vetor exibindo nome a nome 
for (i in 1:length(paises)){
  # Exibe o país
  print(paises[i])
}

# Varre os paises do vetor exibindo nome a nome 
for (i in 1:length(paises)){
  # Se for o segundo pais
  if(i == 2){
    # Pula para o proximo pais
    next()
  }
  # Exibe o país
  print(paises[i])
}

# Varre os paises do vetor exibindo nome a nome 
for (i in 1:length(paises)){
  # Se for o segundo pais
  if(paises[i] == "Dinamarca"){
    # Finaliza laco
    break()
  }
  # Exibe o país
  print(paises[i])
}

# Inicializa indice
i <- 0

# Enquanto não superou o limite de seis impressões
while (i <= 6) {
  # Exibe número da impressão
  print(i)
  # Incrementa contador de impressões
  i <- i + 1
}

# Inicializa indice
i <- 7

# Enquanto não superou o limite de seis impressões
while (i <= 6) {
  # Exibe número da impressão
  print(i)
  # Incrementa contador de impressões
  i <- i + 1
}

# Inicializa índice 
i <- 1

# Laço de repetição até seis voltas
repeat{
  # Exibe número da volta do laço de repetição
  print(i)
  # Incrementa índice de voltas do laço
  i <- i + 1
  # Se superou seis voltas
  if (i > 6){
    break
  }
}