# Instalação de pacotes CSV
install.packages(
  "reader",
  dependencies = TRUE
)

# Carrega pacote para leitura e gravacao de CSV
library(reader)

dados <- read.csv(
  file = "https://www.ufrgs.br/wiki-r/images/b/b6/ExemploDados.csv",
  header = TRUE,
  sep = ";",
  dec = ","
)

# Cria uma base de dados amostral
saldoClientes <- data.frame(
  Cod = 1:100,
  Saldo = sample(
    x = -200:10000,
    size = 300,
    replace = FALSE
  )
)

# Instala pacote de carga e gravacao de csv
# install.packages("data.table", dependencies = TRUE)

# Carrega pacote de carga e gravacao de csv
library(data.table)

# Grava csv
fwrite(
  x = saldoClientes,
  file = "Resultados.csv",
  sep = ";",
  dec = ".",
  row.names = FALSE
)
