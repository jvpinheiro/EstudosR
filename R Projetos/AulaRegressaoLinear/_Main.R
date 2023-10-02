####
## Aula Regressão Linear

# install.packages("ftsa", dependencies = TRUE)
# install.packages("rsample", dependencies = TRUE)
# install.packages("car", dependencies = TRUE)
# install.packages("corrplot", dependencies = TRUE)
# install.packages("knitr", dependencies = TRUE)
# install.packages("tidyverse", dependencies = TRUE)
# install.packages("lubridate", dependencies = TRUE)
# install.packages("readr", dependencies = TRUE)
# install.packages("skimr", dependencies = TRUE)
# install.packages("broom", dependencies = TRUE)
# install.packages("GGally", dependencies = TRUE)

# Carrega pacote
library(rsample)
library(ftsa)
library(car)
library(corrplot)
library(knitr)
library(GGally)
library(tidyverse)
library(lubridate)
library(readr)
library(skimr)
library(broom)

# Consumo de sorvete
consumoSorvete <- tibble(
  KgSorvete = c(
    400L, 
    500L, 
    700L, 
    790L, 
    870L, 
    932L, 
    1100L, 
    1370L, 
    1490L, 
    1670L, 
    1800L
  ),
  Temperatura = 22L:32L
)

grafico <- consumoSorvete %>% 
  ggplot(
    aes(
      x = Temperatura,
      y = KgSorvete
    )
  ) +
  geom_point() +
  ylab(
    label = "Consumo de sorvete (Kg)"
  )

grafico

modelo <- lm(
  formula = KgSorvete ~ Temperatura,
  data = consumoSorvete
)

grafico +
  stat_smooth(
    method = "lm",
    formula = y ~ x,
    geom = "smooth",
    se = TRUE,
    level = 0.95
  )

# Resultados do modelo
summary(modelo)

modelo %>% 
  augment() %>% 
  ggplot(
    aes(
      x = Temperatura,
      y = KgSorvete
    )
  ) +
  geom_point() +
  stat_smooth(
    method = lm, 
    se = FALSE
  ) +
  geom_segment(
    aes(
      xend = Temperatura, 
      yend = .fitted
    ), 
    color = "orange", 
    size = 0.3
  ) +
  ylab(
    label = "Consumo de sorvete (Kg) e resíduos"
  )

# Carrega o arquivo csv
dados <- read_delim(
  file = "https://www.ufrgs.br/wiki-r/images/3/3d/Customer_shopping_data.csv",
  delim = ","
) %>% 
  transmute(
    price,
    gender = factor(gender),
    age = as.integer(age),
    category = factor(category),
    payment_method = factor(payment_method),
    shopping_mall = factor(shopping_mall),
    Mes = month(invoice_date)
  )

# Dados originais
dados %>% 
  head(n = 15) %>% 
  kable()

modelo <- lm(
  formula = price ~ .,
  data = dados
)

summary(modelo)

dados %>% 
  select(category, price) %>% 
  group_by(category) %>% 
  skim()

modelo <- lm(
  formula = price ~ .,
  data = dados
) %>% 
  step()

summary(modelo)

# Carrega o arquivo csv
dadosRealEstate <- read_delim(
  file = "https://www.ufrgs.br/wiki-r/images/5/5f/RealEstate.csv",
  delim = ","
) %>% 
  select(-No) %>% # Remove o identificador de cada linha (ID)
  setNames(c("DataTransacao", "IdadeCasa", "DistanciaTransportePublico", "LojasProximas", "Latitude", "Longitude", "PrecoPorUnidadeArea"))  

# Dados originais
dadosRealEstate %>% 
  head(n = 15) %>% 
  kable()

dadosRealEstate %>% 
  skim()

# Dados originais
dados <- dadosRealEstate %>% 
  filter(
    PrecoPorUnidadeArea > quantile(PrecoPorUnidadeArea, 0.025),
    PrecoPorUnidadeArea < quantile(PrecoPorUnidadeArea, 0.975),
    DistanciaTransportePublico < quantile(DistanciaTransportePublico, 0.95)
  ) 

# Dados originais
dados %>% 
  skim()

corrplot.mixed(
  corr = dados %>% 
    cor(),
  order = "FPC", 
  lower = "number", 
  upper = "circle",
  tl.pos = "lt",
  tl.col = "black"
)

dados %>% 
  rename_all(
    .funs = str_sub, end = 3
  ) %>% 
  ggpairs(
    lower = list(continuous = wrap("points", size = 0.5))
  ) +
  theme(
    axis.text.x = element_text(
      size = 5
    ),
    axis.text.y = element_text(
      size = 5
    )
  )

# Cria modelo
modelo <- lm(
  formula = PrecoPorUnidadeArea ~ .,
  data = dados
)

# Informacoes do modelo
summary(modelo)

# Cria modelo
modeloStep <- lm(
  formula = PrecoPorUnidadeArea ~ .,
  data = dados
) %>% 
  step()

# Informacoes do modelo
summary(modeloStep)

predict(
  modeloStep,
  tibble(
    DataTransacao = 2013.15,
    IdadeCasa = 17.47,
    DistanciaTransportePublico = 855.29,
    LojasProximas = 4.31,
    Latitude = 24.97
  )  
)
