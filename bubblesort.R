# Gera números aleatórios
numeros <- sample(
  x = 100,
  size = 10
)

print("Inicial:")
print(numeros)

for (i in 1:length(numeros))
{
  maior = i
  
  for (j in 1:length(numeros))
  {
    if (numeros[i] < numeros[j])
    {
      aux = numeros[i]
      numeros[i] = numeros[j]
      numeros[j] = aux
      print("Troca:")
      print(numeros)
    }
  }
}
print("Ordenado:")
print(numeros)