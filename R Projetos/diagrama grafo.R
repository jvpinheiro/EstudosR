# Instala o pacote DiagrammeR
install.packages("DiagrammeR", dependencies = TRUE)

# Carrega o pacote
library(DiagrammeR)

# Carrega o pacote
require(DiagrammeR)

# Cria um diagrama para exemplificar
grViz("
  digraph dot {
  a -> {b c d}
}")

# Cria um diagrama para exemplificar
DiagrammeR::grViz("
  digraph dot {
  a -> {b c d}
  c -> a
  d -> e
  e -> {b a}
  f -> a
  a -> f
}")
