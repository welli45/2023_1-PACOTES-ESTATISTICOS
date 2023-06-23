# ESTUDOS


# data.frame --------------------------------------------------------------

exDataFrame <- iris
# acessando as colunas
exDataFrame$Sepal.Length

mean(exDataFrame$Sepal.Length)

sqrt(sum(exDataFrame$Sepal.Width))


# Tibble ------------------------------------------------------------------

# são uma espécie de data.frame, mas com algumas informações a mais. 
library(tidyverse)

exTibble <- as_tibble(iris)

exTibble

# criando tibble

meuTibble <- tibble(a=rnorm(3),
                    b=c("y","x","z"),
                    c=c(1L,2L,3L))
meuTibble

# outra forma de criar um tibble

meuSecTibble <- tribble(
  ~a, ~b, ~c,
  "x", 11, 1.9,
  "y",23, 2.5,
  "z",56,7.9
)

meuSecTibble

meuTerTibble <- tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(LETTERS, 1e3, replace = TRUE)
)

meuTerTibble

rm(list = ls())


# Funções -----------------------------------------------------------------

# criando uma função
# função que calcula os valores de x numa equação de segundo grau

# entradas das funções
a=1
b=-1
c=-30

delta = (b^2)-4*a*c
delta

x1 = (-b+sqrt(delta))/(2*a)
x1

# definindo a função
baska <- function(a,b,c){
  x1 = (-b+sqrt(delta))/(2*a)
  x2 = (-b-sqrt(delta))/(2*a)
  return(c(x1 = x1,x2 = x2))
}

baska(1,-1,-30)

potencia <- function(a,b){
  x = a^b
  return(x)
}

rm(list = ls())
# Execução condicional ----------------------------------------------------

# Exemplo com funcao recursiva: funcao fatorial ====

fatorial <- function(n){
  if(n == 0){
    fat = 1
  } else{
    fat = n * fatorial(n-1)
  }
  return(fat)
}

fatorial(5)

# condições

x = 1:10

# vetor
x==5

x!=5

(x<5)&(x>3)

(x < 5) | (x >= 7)

1:10 == 5

all(1:10 == 5)

any(1:10 == 5)

identical(0L, 0)
# atenção aos pontos flutuantes
x <- sqrt(2) ^ 2
x
x==2
x-2

# multiplas condições

## ifelse() ----
# Suponha que queremos categorizar uma variavel em valores positivos e negativos

x = rnorm(20, 0, 2)
y = ifelse(x <= 0, 0, 1)
cbind(x, y)


# switch ------------------------------------------------------------------

centre <- function(x, type) {
  medida <- switch(type,
                   media = mean(x),
                   mediana = median(x))
  return(medida)
}

x <- rnorm(100)
centre(x, "mediana")

rm(list = ls())

# Bancos de dados já disponíveis no R -------------------------------------

# banco de dados disponíveis no R
data()

data(swiss)

?swiss

rm(list = ls())


# Estatísticas descritivas no R e alguns gráficos -------------------------

alturapeso <- read.csv("http://www.leg.ufpr.br/~paulojus/dados/alturapeso.csv", 
                       head = T)
view(alturapeso)

str(alturapeso)

names(alturapeso)

# transform

?transform

IMC <- transform(alturapeso,
                 alturametro = altura/100,
                 imc = round(peso/(alturametro)^2),
                 classificacaoAltura = ifelse(altura<160, "baixo", ifelse(altura>=160 & altura< 180, "medio", "alto")),
                 classificacaoIMC = ifelse(imc < 18.5,"baixo peso",
                                        ifelse(imc>=18.5 & imc<24.9, "eutrofia",
                                               ifelse(imc>=25&imc<29.9, "sobrepeso",
                                                      ifelse(imc>30,"obesidade","obesidade")))))
# função attach  
attach(IMC)

mean(peso)

max(altura)

# tabelas

# table
(t1 <- table(sexo))
# prop.table
(t2 <- prop.table(t1))

# round
(t3 <- round(prop.table(t1),2))

# função detach
detach(IMC)

(t4 <- table(IMC[,c(1,6)]))

dimnames(t4)
class(t4)
is.matrix(t4)
(t4 <- table(IMC[,c(1,6)], dnn = c("SEXO", "CLASSIFICAÇÃO DE IMC")))

# distribuição marginal
(t5 <- margin.table(t4, mar=2))

(t6 <- addmargins(t4,mar=2))

# tabela 3 variáveis e função with
(t7 <- with(IMC, table(sexo, classificacaoIMC, classificacaoAltura)))

# Eh possivel mudar a visualizacao da tabela com o col.vars
(t8 <- with(IMC, ftable(sexo, classificacaoIMC, classificacaoAltura,
                 dnn = c("Sexo:","Classificação IMC", "Classificação Altura:"), 
                 col.vars = c(1, 3))))

# gráficos
# gráfico de barras
barplot(t1)
# gráfico de pizza
pie(t1)
# melhorando os gráficos
(g1 <- barplot(t1, main = "Ditribuição de Sexo", ylab = "Freqência",
        xlab = "Sexo", col = "blue"))

(g2 <- pie(t1, main = "Proporção de sexo",col = c("red","blue"), 
    labels = paste(c("Feminino - ","Masculino - "),round(prop.table(t1)*100, 2), "%", sep = "")))

attach(IMC)
plot(imc)

plot(factor(imc))

# Podemos plotar dois gráficos na mesma janela gráfica
par(mfrow = c(1,2))
(g1 <- barplot(t1, main = "Ditribuição de Sexo", ylab = "Freqência",
               xlab = "Sexo", col = "blue"))

(g2 <- pie(t1, main = "Proporção de sexo",col = c("red","blue"), 
           labels = paste(c("Feminino - ","Masculino - "),round(prop.table(t1)*100, 2), "%", sep = "")))
# gráfico de barras para duas variáveis
(g3 <- barplot(t4, beside = F, legend = T, col = c(2, 4))) 
(g4 <- barplot(prop.table(t4, 2), beside = F, legend = T, col = c(2, 3)) )

# cores que podemos usar
colours()

# Análise descritiva e exploratória de dados - variáveis quantitativas

data(iris)
iris

head(iris)

attach(iris)

summary(Petal.Length)

summary(iris)

summary(Petal.Length[Species == "Setosa"])

by(iris[,-5], Species, summary)

tapply(Sepal.Length, Species, summary)

# medidas de variabilidade 

var(Sepal.Length)

sd(Sepal.Length)

# matriz de covariâncias
var(iris[,1:4])

# Quantis
quantile(Sepal.Length, probs = c(0.10, 0.25, 0.50, 0.75, 0.90)) 

rm(list = ls())
# Alguns tipos de gráficos ------------------------------------------------

data("swiss")

attach(swiss)

# gráfico de dispersão
plot(Examination, Fertility)
abline(lm(Fertility ~ Examination)) ## Se houver comportamento linear

plot(Examination, Fertility, cex = 2, col = "blue")

# coeficiente de correlação de Pearson
cor(Examination, Fertility)


# Mais sobre a função plot ------------------------------------------------
## 
x = seq(1, 10, by = ) 
x2 = x^2
par(mfrow = c(2, 4))
plot(x, x2)
plot(x, x2, type = "l")
plot(x, x2, type = "b")
plot(x, x2, type = "h")
plot(x, x2, type = "c")
plot(x, x2, type = "s")
plot(x, x2, type = "S")
plot(x, x2, type = "o")

attach(iris)
## O que acontece se plotamos uma variável categórica? 
## E uma variável categórica versus uma variavel continua? 
par(mfrow = c(1, 2))
plot(Species)
plot(Species, Petal.Width)

# Histograma
hist(Sepal.Length) 

hist(Sepal.Length, main = "Histograma para o comprimento da sepala de flores de iris",
     xlab = "comprimento da sepala", ylab = "frequencia")
# Diagrama de ramo e folhas
stem(Sepal.Length)

boxplot(Sepal.Length ~ Species, ylab = "comprimento  da sepala", main = 
          "Boxplot do comprimento da  sepala segundo especie")
## Correlograma
M <- cor(mtcars)
head(round(M, 2))

library(corrplot)

corrplot(M, method = 'color')


rm(list = ls())

# Distribuições de Probabilidade ------------------------------------------

# NORMAL ------------------------------------------------------------------

# calcular a função densidade de probabilidade f(x); P(X=x) no ponto x
# dnorm
args(dnorm)

# calcula a função de probabilidade acumulada F(x) no ponto
# pnorm
args(pnorm)

# fornece valor x tal que P(X≤x)=p, com p conhecido;
# qnorm
args(qnorm)

# retira uma amostra da distribuição.
# rnorm
args(rnorm)

# exemplos
# densidade no ponto -1
dnorm(-1)

# P(X <= -1)
pnorm(-1)

# valor de x
qnorm(pnorm(-1))

# uma amostra normal de 30 elementos
rnorm(30)

# N(100, 100)
# P[X < 95]
pnorm(95,mean = 100, sd = sqrt(100))

# P[90 < X < 110]

pnorm(110, mean = 100, sd = sqrt(100)) - pnorm(90, mean = 100, sd = sqrt(100))

# P[X > 95]
pnorm(95, mean = 100, sd = sqrt(100), lower.tail = F)

par(mfrow = c(1,2))

plot(dnorm, -3, 3)

plot(pnorm, -3,3)

# grafico N(100, 64)
x <- seq(70, 130, len = 100) 
fx <- dnorm(x, 100, 8) 
plot(x, fx, type = "l") 

# Distribuição Binomial ---------------------------------------------------

# dbinom, rbinom, pbinom, qbinom
args(dbinom)
args(rbinom)
args(pbinom)
args(qbinom)

x <- 0:10 
fx <- dbinom(x, 10, 0.35) 
plot(x, fx, type = "h" , ylab= "P(X = x)")

x <- 0:10 
Fx <- pbinom(x, 10, 0.35) 
plot(x, Fx, type = "s", ylab = expression( P(x<=x) ) )

rm(list = ls())

# LOOPS FOR ---------------------------------------------------------------

library(tidyverse)
library(nycflights13)

# loop for para calcular a média de cada coluna em mtcars

media <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
  media[[i]] <- mean(mtcars[[i]])
}
media

tipoCol <- vector("character",ncol(flights))
for (i in seq_along(flights)) {
  tipoCol[[i]] <- typeof(flights[[i]])
}
tipoCol

numunico <- vector("numeric", ncol(iris))
for (i in seq_along(iris)) {
  numunico[[i]] <- length(unique(iris[[i]]))
  
}
numunico

medias <- c(10,0,10,100)
normA <- list()
for (i in seq_along(medias)) {
  normA[[i]] <- rnorm(10, mean = medias[[i]])
}
normA


