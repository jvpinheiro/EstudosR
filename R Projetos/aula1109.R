# Carrega pacote
library(corrplot)
library(knitr)
library(tidyverse)
library(lubridate)
library(readr)
library(fastDummies)
library(skimr)
library(factoextra)
library(cluster)

dados <- read_delim(
  file = "https://www.ufrgs.br/wiki-r/images/3/3d/Customer_shopping_data.csv",
  delim = ","
) %>% 
  mutate(
    gender = factor(gender),
    age = as.integer(age),
    category = factor(category),
    payment_method = factor(payment_method),
    invoice_date = dmy(invoice_date),
    shopping_mall = factor(shopping_mall) 
  )

# Dados originais
dados %>% 
  head(n = 15) %>% 
  kable()


dados <- dados %>% 
  mutate(
    # Padronizar variavel numerica
    age_Pad = ((age - mean(age)) / sd(age)),
    quantity_Pad = ((quantity - mean(quantity)) / sd(quantity)),
    price_Pad = ((price - mean(price)) / sd(price)), 
    
    # Datas    
    DiaDaSemana = invoice_date %>% 
      weekdays() %>% 
      factor(),
    Mes = invoice_date %>% 
      month() %>% 
      factor(),
    Trimestre = invoice_date %>% 
      quarter() %>% 
      factor(),
    Semestre = invoice_date %>% 
      semester() %>% 
      factor(),
    Ano = invoice_date %>%
      year() %>% 
      factor(),
    Feriado = ifelse(
      test = invoice_date %in% c(
        "2020-09-10",
        "2023-09-01",
        "2019-07-01"
      ),
      yes = TRUE,
      no = FALSE
    ),
    VesperaFeriado = ifelse(
      test = invoice_date %in% c(
        "2020-09-09",
        "2023-08-31",
        "2019-06-30"
      ),
      yes = TRUE,
      no = FALSE
    )
  )

# Exibe os dados
dados %>% 
  head(n = 15) %>% 
  kable()

iris %>% 
  dummy_cols()