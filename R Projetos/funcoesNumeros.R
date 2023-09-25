# Trunca (corta) as decimais de um valor 
trunc(x = -10.723456)


# Arredondamento de um valor na 4º casa decimal
round(-10.723456, digits = 4)

# Não considera que a 1º decimal é 7 e resulta em -10
signif(-10.723456, digits = 1)

# Faz arredondamento para o valor 11
signif(-10.723456, digits = 2)

# Faz arredondamento somente considerando a 1º decimal (7) porque a 2º (2) não é significativa
signif(-10.723456, digits = 3)

# Faz arredondamento do valor positivo
ceiling(10.723456)

# Faz arredondamento do valor negativo
ceiling(-10.723456)

# Faz arredondamento do valor positivo
floor(10.723456)

# Faz arredondamento do valor negativo
floor(-10.723456)

# 10 dividido por 3 resulta em 3, não gera decimais
10 %/% 3

# Converte o valor para positivo
valorOriginal <- -10235.12

# Converte o valor para positivo
valorPositivo <- abs(valorOriginal)

# Exibe valor
valorPositivo

# 10 dividido por 2 nao tem resto (resto e zero)
10 %% 2

# 10 dividido por 3 tem resto igual a 1
10 %% 3 

# 11 dividido por 6 tem resto 5
11 %% 6

# Dois na quarta potência 
2^4

# Raiz cúbica de oito
8^(1/3)

# Potência com notação científica
1.33e4^2

# ou 
13300^2

# Valor original
valorOriginal <- 10000

# Calcula a raiz quadrada do valor original
sqrt(x = valorOriginal)

# Calcula raiz cubica 
10^(1/3)

# Calcula raiz quadrupla
10^(1/4)

# Calcula raiz quintupla
10^(1/5)

# Potência, primeiramente
cincoAoQuadrado <- 5^2

# Exibe valor
cincoAoQuadrado

# Se o resultado é 25 e a base é 5, qual foi a potência usada?
log(x = 25,  base=5)

# Função para usar base 10
log10(100000)

# Função para usar base 2
log2(64)

# Valor para teste do exponencial
valor <- 1

# Calcula o exponencial 
exp(valor)

# Calcula chances de ganhar na mega sena
chances <- factorial(60) / ((factorial(60 - 6) * factorial(6)))

# Exibe as chances
chances

# Calcula chances de ganhar na Mega-sena
choose(n = 60, k = 6)

# Apura as possíveis combinações com 5 numeros agrupados de dois em dois
combn(x = 5, m = 2)


# Saldos 
saldos <- c(-10, 25, 41.15, 19)

# Somatorio dos saldos
sum(saldos)

# Saldos 
saldos <- c(-10, 25, 41.15, 19, NA)

# Somatorio dos saldos (sem tratar o NA)
sum(saldos)

# Somatorio dos saldos (com tratamento para NA)
sum(saldos, na.rm = TRUE)

# Valores 
valores <- c(-10, 25, 41.15, 19)

# Produtorio dos saldos
prod(valores)


# Tabela de exemplo
clientes <- data.frame(
  Cod = 1:4,
  Nome = c("João", "Maria", "José", "Pedro"),
  Valor = c(-115.2, 1543.5, 1174.0, 2000.14)
)

# Produtorio dos saldos
prod(clientes$Valor)

  
# Saldos 
saldos <- c(-10, 25, 41.15, 19, NA)

# Produtorio dos saldos (sem tratar o NA)
prod(saldos)

# Produtorio dos saldos (com tratamento para NA)
prod(saldos, na.rm = TRUE)

# Saldos 
saldos <- c(-10, 25, 41.15, 19)

# Media dos saldos
mean(saldos)

# Saldos 
saldos <- c(-10, 25, 41.15, 19)

# Mediana dos saldos
median(saldos)

# Saldos 
saldos <- c(-10, 25, 41.15, 19, 5, 157)

# Mediana dos saldos
quantile(saldos)

# Percentil em 35%
quantile(saldos, probs = 0.35)

# Sem a legenda
quantile(clientes$Saldo, names = FALSE)

# Saldos 
saldos <- c(-10, 25, 41.15, 19, NA)

# Variancia dos saldos
var(saldos, na.rm = TRUE)

# Tabela de exemplo
clientes <- data.frame(
  Cod = 1:4,
  Nome = c("João", "Maria", "José", "Pedro"),
  Saldo = c(-115.2, 1543.5, 1174.0, 2000.14)
)

# Variancia dos saldos
var(clientes$Saldo)

# Saldos 
saldos <- c(-10, 25, 41.15, 19, NA)

# Desvio Padrao dos saldos
sd(saldos, na.rm = TRUE)

# Tabela de exemplo
clientes <- data.frame(
  Cod = 1:4,
  Nome = c("João", "Maria", "José", "Pedro"),
  Saldo = c(-115.2, 1543.5, 1174.0, 2000.14)
)

# Desvio Padrao dos saldos
sd(clientes$Saldo)

# Saldos 
saldos <- c(-10, 25, 41.15, 19, NA)

# Amplitude dos saldos
range(saldos, na.rm = TRUE)

# Tabela de exemplo
clientes <- data.frame(
  Cod = 1:4,
  Nome = c("João", "Maria", "José", "Pedro"),
  Saldo = c(-115.2, 1543.5, 1174.0, 2000.14)
)
  
# Amplitude dos saldos
range(clientes$Saldo)
  
  