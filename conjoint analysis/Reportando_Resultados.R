##################################################
## Choice-Based Conjoint Analysis com Surveys ####
##################################################


# Carrega pacotes básicos
library(dplyr)
library(tidyverse)



## D. Reportando os Resultados do Modelo de Escolha

# Geralmente, é difícil interpretar as estimativas de utilidade de um modelo de escolha diretamente. Por isso, nós usamos os resultados do modelo
# para fazer simulações de escolha (ex., predições de share de escolha de novos produtos) ou para calcular medidas de willigness-to-pay (WTP).


# D.1 Willingness-to-Pay

# No m3 (preço é uma variável numérica), nós podemos usar o parâmetro do preço para computar a média do WTP por um nível particular de um atributo
# dividindo o coeficiente daquele nível pelo coeficiente do preço. O resultado é um número em dólares, $2750.60 nesse caso. Note que dividimos por 1000
# porque os preços da base estavam registrados em milhares de dólares). A maneira correta de interpretar essas medidas é, em média, os clientes são
# indiferentes entre uma minivan com 2ft de espaço de carga e uma minivan de 3ft de espaço de carga que custa $2750.60 a mais. Ou ainda que $2750.60 é o preço
# que torna os clientes indiferentes entre essas duas minivans. Medidas de WTP são reportadas para os gestores e indicam o quanto os clientes valorizam atributos.

# Calcula o WTP para o cargo3f
coef(m3)["cargo3ft"]/(-coef(m3)["as.numeric(as.character(price))"]/1000)

# Calcula o WTP para outros atributos
coef(m3)["enghyb"]/(-coef(m3)["as.numeric(as.character(price))"]/1000)
coef(m3)["enggas"]/(-coef(m3)["as.numeric(as.character(price))"]/1000)



# D.2 Simulador de Escolha

# Medidas de WTP são mais interpretáveis do que os coefs, mas, algumas vezes, elas ainda podem ser difíceis de entender. Por isso, muitos analistas preferem
# utilizar os modelos estatísticos de escolha para fazer previsões de shares de preferência/ escolha. Um simulador de mercado permite que você defina um conjunto
# de alternativas hipotéticas (ex., minivans) com diferentes níveis de atributos e use o modelo estatístico para prever quantos clientes escolheriam tais alternativas.
# Infelizmente, não existe uma função de predição pronta para objetos do mlogit. Tudo bem, pois não é tão difícil a gente escrever a nossa própria. Antes de olhar mais
# a fundo essa função, vamos colocá-la para funcionar e ver o que ela produz.

# Prevendo shares de escolha
predict.mnl <- function(model, data) {
# Função para fazer previsões de escolha a partir de um MLN
      # model: objeto mlogit gerado pelo mlogit()
      # data:  data frame contendo o conjunto de designs para o qual você quer prever os shares.
      # O formato do data é o mesmo usado para estimar o modelo.
      data.model <- model.matrix(update(model$formula, 0 ~ .), data = data)[,-1]
      utility <- data.model %*% model$coef
      share <- exp(utility)/sum(exp(utility))
      cbind(share, data)
      }

# Como iremos prever os shares de escolha de um conjunto de diferentes alternativas, precisamos de uma lista com nossos atributos e níveis. 
# Cria uma lista chamada "attrib" que armazena os atributos e seus respectivos níveis
attrib <- list(
  seat = c("6", "7", "8"),
  cargo = c("2ft", "3ft"),
  eng = c("elec", "gas", "hyb"),
  price = c("30", "35", "40")
)

# Cria o conjunto completo de todas os designs possíveis usando a função expand.grid() e seleciona, pelas linhas, os designs que queremos testar
(new.data <- expand.grid(attrib)[c(8, 1, 3, 41, 49, 26), ])

# Então, passamos o modelo estimado (m1) e os designs na função predict.mnl para obter as estimativas do que os clientes escolheriam se 
# eles tivessem apenas essas seis opções. Os resultados mostram que, por exemplo, os clientes escolheria a opção 1 16% das vezes.
# Para aqueles que são novos em modelos de escolha, precisamos tomar alguns cuidados antes de aplicar/ comunicar seus resultados:
# .Shares de escolha são sempre relativos a um conjunto particular de competidores (os shares da opção 1 mudariam com diferentes competidores);
# .Shares de escolha não são a mesma coisa do que market-shares. Apesar dessas previsões serem uma ótima representação de como os respondentes se 
# comportariam se eles tivessem que escolher uma dessas 6 minivans, há pelo menos três razões para essas previsões não se traduzirem exatamente em vendas no mercado.
# Primeiro, fora do experimento, o nível de awareness em direção às alternativas pode não ser o mesmo. Segundo, o cliente pode não ter acesso ao produto (distribuição).
# Terceiro, os clientes tendem a subestimar o efeito do preço nas suas escolhas, um efeito conhecido como hypothetical bias. Dito tudo isso, porém, existem inúmeros estudos 
# documentando os significativos benefícios da conjoint para gestão de preços e produtos, como, por exemplo, compreensão do que realmente importa para os clientes e o
# desenvolvimento de um mindset científico para o comportamento dos clientes.

# Calcula os shares de escolha de cada uma das alternativas do design
predict.mnl(m1, new.data)


# Agora que vimos o que a função predict.mnl retorna, podemos olhar com mais calma para sua estrutura.

# A primeira linha da função converte os dados, os quais estão inicialmente armazenado como fatores, para uma "coded matrix". Uma 'coded matrix" é uma matriz em que os
# atributos são recodificados para um novo formato (formato dummy), em que o primeiro nível de cada atributo é omitido e os demais são parametrizados de forma que seu
# coeficiente representará a utilidade desse nível em comparação ao nível base (omitido).
data.model <- model.matrix(update(model$formula, 0 ~ .), data = data)[,-1]  # NÃO PRECISA RODAR
new.data # Os dados que serão passados na função predict.mnl
model.matrix(update(m1$formula, 0 ~ .), data = new.data)[,-1] # E o resultado da primeira linha de predict.mnl

# A próxima linha do predict.mnl computa a utilidade de cada minivan. Isso é feito muiltiplicando a "coded matrix" resultante do passo anterior pelos coeficientes estimados
# pelo modelo estatístico no mlogit(). Isso irá produzir um valor de utilidade de cada produto baseado nos seus atributos. Perceba que essa fórmula assume que a escolha de um
# cliente é um processo multi-atributo, em que o valor total de um produto (utilidade) é igual a soma das utilidades de seus atributos. 
utility <- data.model %*% model$coef # NÃO PRECISA RODAR
data.model <- model.matrix(update(m1$formula, 0 ~ .), data = new.data)[,-1] # Criando o objeto data.model usar no exemplo
m1$coef # Visualizando o conteúdo do objeto model$coef
data.model %*% m1$coef # O resultado da segunda linha do predict.mnl

# Finalmente, na última linha, nós convertemos as utilidades em probabilidades de escolha usando a equação de um logit multinomial. Perceba que a equação utilizada para prever
# o comportamento de escolha dos clientes, ou seja, converter as utilidades em probabilidades escolha, faz outra importante suposição: as probabilidades de escolha de um produto
# depende do conjunto de escolha considerado.
share <- exp(utility) / sum(exp(utility)) # NÃO PRECISA RODAR
utility <- data.model %*% m1$coef # Criando o objeto utility para usar no exemplo
exp(utility) / sum(exp(utility)) # O resultado da terceira linha do predict.mnl



