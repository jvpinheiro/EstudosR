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
  maior <- numeros[i]
  for (j in 1:length(numeros))
  {
    if (maior < numeros[j])
    {
      aux <- numeros[i]
      numeros[i] <- numeros[j]
      numeros[j] <- aux
      
      maior <- numeros[j]
      
      print("Troca:")
      print(numeros)
    }
  }
  iteracoes <- iteracoes + 1
}
print("Ordenado:")
print(numeros) 
