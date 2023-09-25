##################################################
## Choice-Based Conjoint Analysis com Surveys ####
##################################################


# Carrega pacotes básicos
library(dplyr)
library(tidyverse)
library(skimr)


# Carrega base de dados
cbc.df <- read.csv(
  "http://goo.gl/5xQObB",
  colClasses = c(carpool = "factor", seat = "factor", cargo = "factor", eng = "factor", price = "factor", choice="integer")
  )




## C. Modelando Dados de Escolha dos Clientes com mlogit()

# Como qualquer outro processo de modelagem, não existe um layout de dados universal.
# Então, geralmente, começamos manipulando os dados e os colocando em algum layout especial.



# Coloca a base no formato wide, ou seja, cada linha é uma pergunta ou exercício de escolha da conjoint.
# Além disso, renomeia, recodifica, organiza etc. a base de dados. 
cbc.df <- cbc.df %>% 
  mutate(
    alt = case_when(
      alt == 1 ~ "A",
      alt == 2 ~ "B",
      .default = "C"
    )
  ) %>% 
  pivot_wider(
    names_from = alt,
    values_from = 5:9
  ) %>% 
  mutate(
    choice = case_when(
      choice_A == 1 ~ "A",
      choice_B == 1 ~ "B",
      choice_C == 1 ~ "C"
    )
  ) %>% 
  select(-starts_with("choice_")) %>% 
  select(resp.id, ques, choice, seat_A:price_C, carpool) %>% 
  rename(id = resp.id, choiceid = ques) %>% 
  distinct(id, choiceid, .keep_all = TRUE) %>%  # Garante que não há id e choice.id duplicados  
  view()

# Substitui o vetor choice.id (exercícios de escolha) por uma sequência de números únicos.
# Isso é um requisito do mlogit().
cbc.df <- cbc.df %>% 
  mutate(
    choiceid = 1:nrow(.)
  )

# Visualiza a base de dados resultante
cbc.df %>% view()


# Carrega o mlogit()
library(mlogit)

# Aplica a função dfidx na base de dados e a coloca no formato exigido pelo mlogit()
cbc.mlogit <- dfidx(
  data = cbc.df,
  choice = "choice",
  shape = "wide",
  varying = 4:15,
  sep = "_",
  idx = list(c("choiceid", "id")),
  idnames = c(NA, "alt")
  )


# Utiliza o cbc.mlogit para estimar o modelo de escolha com a função mlogit().
# Repare no padrão da fórmula: "escolha" à esquerda do "~" e "atributos" à direita.
m1 <- mlogit(
  choice ~ 0 + seat + cargo + eng + price, 
  data = cbc.mlogit
  )

# Mostra o resumo da estimação do modelo estatístico. São pontos importantes para analisarmos:
# .A parte de baixo do output mostra uma tabela de coeficientes de utilidade;
# .Como nossos preditores foram parametrizados como variáveis categóricas, a interpretação dos coeficientes deve ser feita em relação ao nível omitido de cada atributo.
# Por exemplo, seat7 mostra a utilidade de 7 lugares em comparação a um de 6 lugares; seat8 mostra a utilidade de 8 lugares em comparação a um de 6 lugares;
# .O sinal de cada coeficiente nos indica a direção da preferência (ex., um coeficiente negativo indica que, em comparação à base, o nivel do atributo é menos preferido);
# .O tamanho do coeficiente nos indica o tamanho ou grandeza do coeficiente (ex., coeficientes maiores indicam preferência mais forte);
# .O erro padrão (Std. Error) dá uma ideia de precisão. Ele é usado para o teste estatístco se o coeficiente é diferente de zero (ex., se tem efeito ou não nas escolhas). 
# .O resultado desse teste produz um p-valor (Pr(>|Z|)), que é um indicador de significância estatística (ex., tem uma baixa probabilidade de o coef ser igual a diferente).
summary(m1)
m1$model


# Você pode estar se perguntando o porquê colocamos um "zero" no modelo m1. O "zero" faz com que o mlogit() estime o modelo de escolha sem um intercepto...
# Estima o modelo de escolha com intercepto. Quando fizemos isso, dois novos parâmetros são incluídos na tabela de outputs: (Intercept):B e (Intercept):C.
# Esses coefs capturam a preferência pelas alternativas B e C (em relação à A, que foi omitida como base) quando todos os outros atributos são zero. Ou seja,
# na prática, o que esses coefs estão capturando é a preferência pelas posição das alternativas (B= segunda posição da esquerda para direta; C= terceira posição).
# Para o tipo de conjoint que estamos aplicando (unlabeled), esses coefs não possuem efeito nas escolhas, porque não esperamos que a preferência de um minivan depende da posição
# em que ela foi apresentada nos exercícios de escolha. No entanto, é sempre importante testarmos, porque os consumidores são sujeitos a vieses cognitivos (ex., status quo).
m2 <- mlogit(
  choice ~ 1 + seat + cargo + eng + price,
  data = cbc.mlogit
  )
summary(m2)

# Testa formalmente se o modelo com intercepto (m2) explica melhor as escolhas dos clientes do que o modelo sem intercepto (m1).
# O p-valor do teste é bem maior do que 0.05 (ie., 0.7122), indicando que não existe diferença em termos de ajuste entre o m1 e m2.
lrtest(m1 , m2)

# Um último ponto: você não precisa tratar todos os atributos como variáveis não numéricas/ categóricas. Por exemplo, nós podemos incluir o price na fórmula
# como um preditor numérico. Isso é feito com as.numeric(as.character(price)). Agora, o ouput mostra apenas um coef para o price (em vez de um para cada nível - 1).
# O sinal negativo indica que a utilidade da alternativa (minivan) diminui com o aumento do preço.
m3 <- mlogit(
  choice ~ 0 + seat + cargo + eng + as.numeric(as.character(price)),
  data = cbc.mlogit
  )
summary(m3)

# Faz o teste formal se m3 (price é numérico) é superior ao m1 (price é categórico, com o preço mais baixo servindo como base de referência)
lrtest(m1, m3)




