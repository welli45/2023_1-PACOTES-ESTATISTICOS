# Wellington Santos Souza - 2019012213
# carregando pacotes
library(aplore3)
library(jmv)

# banco de dados 
?glow_bonemed

data(glow_bonemed)

# Q1
attach(glow_bonemed)

# a
(ta <- table(glow_bonemed[,c(12,13)])) 

prop.table(ta, margin = 2)

# b
glow_bonemed$height <- cut(glow_bonemed$height, c(0, 150, 155, 160, 170, 175),
                           labels = c("Pequeno", "Baixo", "Médio", "Alto", "Grandão"))
(tb <- table(glow_bonemed$height))

# usando o pacote jmv
descriptives(glow_bonemed, vars = vars(height), freq = TRUE)

# c
barplot(prop.table(table(glow_bonemed$raterisk)), beside = F, col = "blue",
        ylab = "Frequência", xlab = "Rate Risk", main = "Gráfico de Barras: Rate Risk")
# d
boxplot(weight ~ smoke, col = c("red", "blue"))
title("Boxplot: Weight X Smoke")

rm(list = ls())

# Q2
# a
matBinom <- function(a, n){
  matriz <- cbind(a, bin = rbinom(n = n, size = 100,prob = 0.5))
  print(matriz)
}

matBinom(2,6)

# b

A <- matrix(1:10,ncol = 2, nrow = 5)
A

varMat <- function(x){
  matt <- vector("numeric", ncol(x))
  for (i in seq_along(x)) {
    matt[[i]] <- var(x[[i]])
  }
  return(matt)
}

varMat(A)  

# c

invoque_ma

rm(list = ls())
# Q3

# função 1

fx <- function(x){
  te=3
  k=2
  lmb=4
  ((te^k)/factorial(k-1))*(x^(k-1))*exp(-x*te)
}

fx(2)

# função 2 
gx <- function(x){
  te=3
  k=2
  lmb=4
  (lmb*exp(-x*lmb))
}
gx(2)

plot(fx)

plot(gx)

rm(list = ls())

# Q4 

# a
# distribuição exponencial
qexp(p = 0.07, rate = 4)

#  b
# distribbuição geométrica
dgeom(x = 5, prob = 0.3)

# c
# distribbuição geométrica
pgeom(q = 4, prob = 0.3, lower.tail = F)

# d
# distribuição exponencial
x <- rexp(n = 1000, rate = 4)

# proporção dos valores maiores que 0.09
mean(x>0.09)
# ou
prop.table(table(x>0.09))
  




