##################################################
## Choice-Based Conjoint Analysis com Surveys ####
##################################################


## A. MOTIVAÇÃO

# 1-
# Como analisar a escolha de clientes dentro de uma categoria de produtos ou servicos? 
# Como modelar o efeito que atributos, marcas e preços têm sobre a escolha de clientes?

# 2-
# Por exemplo, após um profunda pesquisa na internet, um cliente faz o seguro de seu carro no app do Banrisul.
# Nesse caso, nós poderíamos estruturar esse problema como o cliente escolhendo uma alternativa específica de seguro
# (preço, marca, apólice etc.) entre todas as outras alternativas de seguros disponíveis para ele nessa busca.
# Esses dados poderiam então ser usados para estimar quais atributos foram mais atrativos no processo de decisão,
# bem como os trade-offs que ele estava dispoto a fazer contra o preço.

# 3- 
# Para modelar a relação entre atributos (preço, marca, qualidade) e escolha do cliente, é usada uma técnica de data analytics
# conhecida como modelo logístico multinomial (MNL). Essa técnica tem suas raízes na microeconomia, e seu percursor foi laureado no ano 2000
# com o Prêmio Nobel de Ciências Econômicas. Por meio do MNL, é possível estimar a valoração de atributos, a disposição a pagar e
# a demanda e shares de preferência de alternativas de produtos ou serviços.

# 4-
# Apesar de um modelo MNL ser usado para analisar compras no varejo, muitas vezes, não conseguimos os dados necessários para modelar a compra de um produto.
# Por exemplo, quando as pessoas compram um carro, elas buscam informação a partir de diferntes fontes e ao longo de vários meses, tornando muito
# difícil o processo de reconstrução das altetnativas consideradas e as das características e preços dessas características. Em situações como essas,
# cientistas de dados adotam uma conjoint analysis (ou experimento de escolha), que é um método baseado em survey (questionário) em que os clientes atuais
# e potenciais são solicitados a fazer escolhas entre produtos com preços e atributos variando.
 
# 5- 
# Comparado a surveys tradicionais (ex., pesquisa de preferência com escalas de intensidade quantitativa), o método da conjoint possui marcadas vantagens.
# Ela minimiza os vieses cognitivos, como, por exemplo, o positivity bias (yea-saying), straightlining e o ruído gerado pela falta de um benchmark adequado.




## B. UM EXEMPLO SIMPLES E PRÁTICO 

# 1-
# Suponha que a Toyota esteja projetando uma nova linha de minivans e tentando determinar o tamanho e o tipo de motor que ela deve ter.
# Para informar esta decisão, seria útil compreender como os clientes valorizam esses diferentes atributos.
# Os clientes gostam ou não gostam de motores híbridos? Se sim, quanto mais estariam dispostos a pagar por um motor híbrido?
# Existem segmentos de clientes que gostam mais de motores híbridos do que outros clientes?

# 2-
# A conjoint fornece aos gestores informações sobre como os clientes escolhem os produtos, pedindo para os clientes responder a perguntas como a abaixo.
# Nessa conjoint, existem três alternativas, cada uma descrita por quatro atributos (capacidade, carga, motor e preço). Cada atributo é descrito por dois
# ou mais níveis. Por exemplo, os níveis possíveis no atributo área de carga são 2 e 3 ft. Numa típica conjoint, nós pedimos a potenciais clientes
# (prováveis compradores) responder uma sequência de perguntas como a da figura abaixo; cada pergunta (cenário), possui a mesma estrutura, mas os níveis
# dos atributos das alternativas variam de um cenário para outro.

# Qual das minivans abaixo você compraria?
# Assuma que as três minivans são idênticas em qualquer outra característica além das listadas abaixo.

#                       OPÇÃO 1           OPÇÃO 2           OPÇÃO 3
#                       6 passageiros     8 passageiros     6 passageiros
#                       2 ft. área carga  3 ft. área carga  3 ft. área carga
#                       motor gasolina    motor hibrido     motor gasolina
#                       $35,000           $30,000           $30,000
# I prefer (check one): [ ]               [ ]               [X]


# Outro exemplos
# https://conjointly.com/img/example-conjoint-task-mobile-phone.png


# Carrega pacotes
library(dplyr)
library(tidyverse)
library(skimr)

# Carrega base de dados
cbc.df <- read.csv(
  "http://goo.gl/5xQObB",
  colClasses = c(carpool = "factor", seat = "factor", cargo = "factor", eng = "factor", price = "factor", choice="integer")
)

# Visualiza as classes da base
glimpse(cbc.df)

# Visualiza a base de dados de forma bruta
cbc.df %>% 
  view()


# 3-
# Explorando os Dados de Escolha. Como em qualquer outro tipo de modelagem, é importante começar compreendendo os dados usando descrições básicas.

# Visualiza as primeiras 20 linhas do data frame cbc.df
head(cbc.df, 20)

# Aplica a função skim() para descrição básica da base
cbc.df %>% 
  skim()

# Conta o número de vezes que uma alternativa foi escolhida por nível de atributo
cbc.df %>%
  group_by(price, choice) %>% # Substitua o price pelos outros atributos
  summarize(count = n()) %>% 
  group_by(price) %>%
  mutate(relative_proportion = count / sum(count)) %>% 
  filter(choice == 1)





