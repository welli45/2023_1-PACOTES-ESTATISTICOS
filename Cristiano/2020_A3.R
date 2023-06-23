#############################################################
#######  Script da Aula 3 - Pacotes estatisticos  ###########
#############################################################
getwd()

#-----------------------------------------------------------
# Distribuicao normal padrao

#As funções com distribuição normal são implementadas usando o termo norm. 
#Por default as funções assumem a distribuição normal padrão N(μ = 0,σ^2 = 1)
## OBS: Note que devemos passar o desvio padrão como argumento e não a variância

dnorm(-1) # calcula a densidade de probabilidade f(x) no ponto
pnorm(-1) # calcula a função de probabilidade acumulada F(x) no ponto
qnorm(0.975) #calcula o quantil correspondente a uma dada probabilidade
rnorm(10) #retira uma amostra da distribuição

# Argumentos da funcao
args(rnorm)
# function (n, mean = 0, sd = 1) 
# NULL

## Exemplo do slide
# Seja X uma v.a. com distribuição N(100,100)
## 1.P[X < 95]
## 2.P[90 < X < 110]
## 3.P[X > 95]

# N(100, 100)
## 1:
pnorm(95, 100, 10)
## 2:
pnorm(110, 100, 10) - pnorm(90, 100, 10)

## 3 (duas possibilidades):
1 - pnorm(95, 100, 10)
pnorm(95, 100, 10, lower = F)

# Graficos da densidade e distribuicao acumulada da N(0,1)
x11()
par(mfrow=c(1,2))
plot(dnorm, -3, 3) 
plot(pnorm, -3, 3)

## ou curve(dnorm,-3,3)

# Graficos da densidade e distribuicao acumulada
## Gráficos da  N(μ = 100,σ^2 = 64)
x11()
par(mfrow=c(1,2))
x <- seq(70, 130, len = 100) 
fx <- dnorm(x, 100, 8) 
plot(x, fx, type = "l") 
Fx <- pnorm(x, 100, 8) 
plot(x, Fx, type = "l")

# Ou
plot(function(x) dnorm(x, 100, 8), 70, 130) 
plot(function(x) pnorm(x, 100, 8), 70, 130)

##
x11()
par(mfrow=c(1,2))
plot(dnorm, -3, 3, xlab = "valores de X", ylab = "densidade de probabilidade") 
title("Distribuicao Normal\nX ~ N(100, 64)") 
plot(function(x) dnorm(x, 100, 8), 60, 140, ylab = "f(x)", lwd = 2) 
plot(function(x) dnorm(x, 90, 8), 60, 140, add = T, col = 2 , lwd = 2, lty = 2) 
plot(function(x) dnorm(x, 100, 15), 60, 140, add = T, col = 3 , lwd = 2, lty = 4) 
legend(110, 0.05, c("N(100,64)", "N(90,64)", "N(100,225)"), col = 1:3, lwd=2, lty=c(1,2,4))


## Curva da distribuicao Normal sobre o histograma
x11()
x=rnorm(100,0,10)
hist(x,prob=TRUE)
lines(sort(x),dnorm(sort(x),0,10))

#-----------------------------------------------------------
# Distribuicao binomial
## A distribuição Binomial inclui a Bernoulli como caso particular;
## Funções: dbinom, rbinom, pbinom, qbinom.

args(dbinom)
help(dbinom)

# Seja X uma v.a. com distribuição Binomial com n = 10 e p = 0.35. 
# Vamos ver os comandos do R para:
## 1. fazer o gráfico das função de densidade
## 2. idem para a função de probabilidade
## 3. calcular P[X = 7]
## 4. calcular P[X < 8]
## 5. calcular P[X ≥ 8]
## 6. calcular P[3 < X ≤ 6]

# Graficos da Binomial
x <- 0:10 
fx <- dbinom(x, 10, 0.35) 
plot(x, fx, type = "h" )
Fx <- pbinom(x, 10, 0.35) 
plot(x, Fx, type = "s")

## Probabilidades pedidas no slide
dbinom(7, 10, 0.35)
pbinom(7, 10, 0.35)
sum(dbinom(0:7, 10, 0.35))
1 - pbinom(7, 10, 0.35)
pbinom(7, 10, 0.35, lower = F)
pbinom(6, 10, 0.35) - pbinom(3, 10, 0.35)
sum(dbinom(4:6, 10, 0.35))

#-----------------------------------------------------------
## OUTRAS DISTRIBUIÇOES
# Uniforme contínua: runif, punif, dunif, qunif
# Poisson: rpois, …
#Outras distribuições: 
# dbeta, dcauchy, dchisq, dexp, df, dgamma, dgeom, dlnorm, dmultinom, dnbinom, dt, dweibull

## Gerando da uniforme discreta
sample(1:10, 15, rep = T)

#sample: 
# A função sample() não é restrita à distribuição uniforme discreta, 
# podendo ser usada para sorteios, com ou sem reposição 
# (argumento replace, default sem reposição), 
# com a possibilidade de associar diferentes probabilidades a cada elemento 
# (argumento prob, default probabilidades iguais para os elementos).

# argumentos
args(sample)
# sorteio de 3 numeros entre os inteiros de 0 a 20
sample(0:20, 3)
# sorteio de 5 numeros entre os elementos de um certo vetor
x <- c(23, 34, 12, 22, 17, 28, 18, 19, 20, 13, 18) 
sample(x, 5)
# sorteio de 10 numeros entre os possiveis resultados do lancamento de um dado, com reposicao
sample(1:6, 10, rep = T)
# idem ao anterior, porem agora com a probabilidade de cada face proporcional ao valor da face.
sample(1:6, 10, prob = 1:6, rep = T) # prob pode ser pesos!


#-----------------------------------------------------------

# Gerando de uniforme discreta no quadrado e vendo o caminho percorrido graficamente
set.seed(13042013)
n <- 16
seq <- 1:n
x <- sample(seq)
y <- sample(seq)
plot(x,y, axes=FALSE)
axis(1,1:n)
axis(2,1:n)
axis(3,1:n)
axis(4,1:n)
abline(h=1:n, v=1:n, col="gray", lty=3)
arrows(x[1:n-1],y[1:n-1], x[2:n], y[2:n])
par(new=TRUE)
plot(x[1],y[1], 
     col = "green", 
     lwd = 2, 
     xlim = range(x), 
     ylim = range(y), 
     xlab = "",
     ylab = "")
par(new=TRUE)
plot(x[n],y[n], 
     col="red", 
     lwd = 2, 
     xlim = range(x), ylim = range(y), 
     xlab = "",
     ylab = "")


#-----------------------------------------------------------
## Como fazer para trabalhar com uma distribuicao que nao esteja no R:
# Podemos implementar uma função que calcule a probabilidade ou de 
# densidade da distribuição de interesse.

fn <- function(x) { 
  fx <- (1/sqrt(2 * pi * 100)) * exp((-1/200) * (x - 100)^2) 
  return(fx) 
}

# No caso de uma distribuição contínua, com a função polygon podemos 
# destacar alguma área de interesse:
# Grafico com area destacada
x <- seq(70, 130, l = 200) 
fx <- fn(x) 
plot(x, fx, type = "l") 
ax <- c(70, 70, x[x <= 95], 95, 95) 
ay <- c(0, fn(70), fx[x <= 95], fn(95), 0) 
polygon(ax, ay, dens = 10)

# No caso de uma distribuição contínua, podemos utilizar a função integrate para 
# calcular alguma probabilidade de interesse:
# Funcao integrate
integrate(fn, -Inf, 95) # Acumulada no ponto 95
integrate(fn, 90, 110)  # P[90 < X < 110]
integrate(fn, 95, +Inf) # P[X > 95]

## Para gerar amostras de uma densidade diferente das disponiveis no R eh necessario buscar algum pacote ou 
## implementar metodos de geracao que fogem ao scopo da disciplina

#---------------------------------------------------------------
## Graficos para distribuicoes multivariadas

install.packages("mvtnorm", dependencies = FALSE)
require(mvtnorm) # Normal multivariada
# Funções:
#contour
#image
#persp
#persp3d

# Grafico de curvas de nivel
sigma <- matrix(c(1,0.5,0.5,1), ncol = 2)
x1 = x2 = seq(-2.5, 2.5, by=0.1)
a = expand.grid(x=x1, y=x2) 
y = matrix(dmvnorm(x = a, 
                   mean = c(0,0),
                   sigma = sigma),
           nrow=length(x1))
win.graph()
par(mar = c(4, 4, 3, 3))
contour(x1, x2, y, 
        lwd = 1.5, 
        labcex = 1.2, 
        cex.axis = 1.2, 
        cex.lab = 1.8)

# adicionando pontos de uma amostra gerada
x <- rmvnorm(n=100, mean=c(0,0), sigma=sigma, method="chol")
points(x, pch=16, col = 2)

## Grafico de imagem
x11()
image(x1, x2, y, col  = topo.colors(20))
contour(x1, x2, y, 
        lwd=1.5, 
        labcex = 1.2, 
        cex.axis=1.2, 
        cex.lab=1.8,
        add=T)

#-------------------------------------------------------------------------
## Graficos 3D
#install.packages("rgl")
require(rgl)

# Fixo
win.graph()
persp(x1, x2, y, 
      theta = 210, 
      phi = 20, 
      expand = 0.75,
      d=1, 
      zlab="",
      xlab="nu1",
      ylab="nu2", 
      shade = 0.5, 
      ticktype = "detailed",r=2)

# Interativo
x11()
op <- par(bg = "white")
open3d()
persp3d(x1, x2, y, 
        expand = 0.25, 
        zlab="", 
        main=" ",
        xlab=expression(nu[1]),
        ylab=expression(nu[2]),
        col=2)


## no lattice
#install.packages("lattice")
require(lattice)
g = data.frame(x1 = x1, x2 = x2, y = as.vector(y))
wireframe(y ~ x1*x2, 
          data = g, 
          drape = TRUE, 
          col.regions = heat.colors(150),
          colorkey = TRUE,  
          screen = list(z = -60, x = -60))






