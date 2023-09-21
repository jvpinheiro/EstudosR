library(tidyverse)

iris %>% 
  filter(
    Sepal.Length >= 7
  )

starwars %>% 
  filter(
    species == "Human"
  ) %>% 
  select(name, mass) %>% 
  mutate(mass2 = mass / 3) %>% 
  filter(near(mass2, 25.7, tol = 0.5))


starwars %>% 
  filter_all(any_vars(. == "brown"))

starwars %>% 
  filter_if(is.character,
            any_vars(. == "male"))


starwars %>% 
  filter_at(vars(ends_with("color")),
            any_vars(. == "black" | . == "blue"))

starwars %>% 
  arrange(eye_color, name)

starwars %>% 
  group_by(homeworld) %>% 
  arrange(name, .by_group = TRUE)

starwars %>%
  group_by(eye_color) %>%
  arrange(sex, .by_group = TRUE) %>% 
  View()

starwars %>% 
  select(name, ends_with("color"))

starwars %>% 
  select(contains("_"))

starwars %>% 
  rename(
    NomeDoPersonagem = name,
    Planeta = homeworld,
    Especie = species
  )

starwars %>% 
  select(skin_color, everything(), -height, -mass, vehicles:last_col())

# Cria a coluna altura em metros a partir da coluna height que esta em centimetros
starwars %>% 
  mutate(AlturaMetros = height / 100) %>% 
  select(homeworld, height, AlturaMetros, everything()) 

# Cria coluna com o indice de massa corporal
starwars %>% 
  mutate(IMC = mass / ((height / 100)^2)) %>% 
  select(homeworld, height, IMC, everything())

# Media movel do Peso e tratamento do primeiro registro (NA)
starwars %>%
  mutate(MediaMovelPeso = (mass + lag(mass, n = 1)) / 2) %>% 
  mutate(MediaMovelPeso = coalesce(MediaMovelPeso, mass)) %>%  
  select(mass, MediaMovelPeso)


# Valores para exemplo
(valores <- c(1, 1, 3, 1, 2, 6, 7, 0, 0, 9))
# Cria exemplos de ranking
tibble(
  # Valores para exemplo
  Valores = valores,
  # Ordena valores e cria coluna com numero da linha
  Row_Number = row_number(Valores),
  # Ordena valores e cria coluna com numero da linha que o valor aparece pela primeira vez
  Min_Rank = min_rank(Valores),
  # Ordena valores e cria coluna com 
  Percent_rank = percent_rank(Valores),
  # Ordena valores e cria coluna sequencia em que aparece cada valor
  Dense_rank = dense_rank(Valores),
  # Distribuição de 0 ~ 1 com base na ultima linha em que aparece o valor da coluna ordenado
  Cume_Dist = cume_dist(Valores),
  # Cria sequencia de 1 ate valor definido no parametro n
  NTile = ntile(Valores, n = 901)
) %>% 
  arrange(valores)

# Valores para exemplo
valores <- c(1001, 12, 543, NA, 2000)

# Cria exemplos de ranking
tibble(
  # Valores para exemplo
  Valores = valores,
  # Acumula a coluna valores ate que o conteudo aparece pela primeira vez
  Cumsum = cumsum(valores),
  # Acumula a coluna valores com valor medio do valor atual mais os anteriores
  Cummean = cummean(valores),
  # Produtorio da coluna do valor atual com os anteriores
  Cumprod = cumprod(valores),
  # Verifica se o valor pode ser acumulado
  Cumall = cumall(valores),
  # Verifica se o valor pode ser acumulado
  Cumany = cumany(valores),
  # Maior valor que pode ser acumulado
  Cummax = cummax(valores),
  # Menor valor que pode ser acumulado
  Cummin = cummin(valores)
)

# Valores para exemplo
valores <- c(1001, 12, 543, NA, 2000)

# Substitui o valor 12 por NA
tibble(
  # Valores para exemplo
  Valores = valores,
  Val2 = na_if(valores, 12)
) 

# Valores para exemplo
valores <- c(1001, 12, 543, NA, 2000)

# Substitui NA por 0
tibble(
  # Valores para exemplo
  Valores = valores,
  Val2 = coalesce(valores, 0)
) 

# Exemplo de dados com pintores
pintores <- c(
  "Sandro Botticelli",
  "Botticelli",    
  "Salvador Dalí", 
  "Salvador"
)

# Padroniza o nome Botticelli para Sandro Botticelli
pintoresN <- recode(pintores, Botticelli = "Sandro Botticelli")
recode(pintoresN, Salvador = "Salvador Dalí")

# Cria coluna com tipos
starwars %>%
  select(name:mass, gender, species) %>%
  mutate(
    type = case_when(
      height > 200 | mass > 200 ~ "large",
      species == "Droid"        ~ "robot",
      TRUE                      ~ "other"
    )
  )

# Media de altura e media de peso (retira os NAs)
starwars %>% 
  filter(!(is.na(height) | is.na(mass))) %>% 
  summarize(AlturaMedio = mean(height / 100),
            PesoMedio = mean(mass))

# Calculando a índice de massa corporal geral
starwars %>% 
  filter(!(is.na(height) | is.na(mass))) %>% 
  summarize(AlturaMedia = mean(height / 100),
            PesoMedio = mean(mass)) %>% 
  mutate(IMC = PesoMedio / AlturaMedia^2)


# Classifica o grau de massa corporal 
starwars %>% 
  filter(!(is.na(height) | is.na(mass))) %>% 
  group_by(homeworld, gender) %>% 
  summarize(AlturaMedia = mean(height / 100),
            PesoMedio = mean(mass)) %>% 
  mutate(IMC = PesoMedio / AlturaMedia^2) %>% 
  mutate(DescricaoIMC = case_when 
                          (
                            IMC >  40   ~ "Obesidade Grau III (mórbida)",
                            IMC >= 35   ~ "Obesidade Grau II (severa)",
                            IMC >= 30   ~ "Obesidade Grau I",
                            IMC >= 25   ~ "Sobrepeso",
                            IMC >= 18.5 ~ "Saudável",
                            IMC >= 17   ~ "Magreza leve",
                            IMC >= 16   ~ "Magreza moderada",
                            TRUE        ~ "Magreza grave"
                          )
  )
