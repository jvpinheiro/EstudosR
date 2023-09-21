# Gera números aleatórios
numeros <- sample(
  x = 100,
  size = 100
)

print("Inicial:")
print(numeros)
iteracoes <- 0

for (i in 1:length(numeros)-iteracoes)
{
  maior <- i
  for (j in 1:length(numeros))
  {
    if (numeros[i] < numeros[j])
    {
      aux <- numeros[i]
      numeros[i] <- numeros[j]
      numeros[j] <- aux
      print("Troca:")
      print(numeros)
    }
  }
  iteracoes <- iteracoes + 1
}
print("Ordenado:")
print(numeros)