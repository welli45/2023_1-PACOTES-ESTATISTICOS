#############################################################
#######  Script da Aula 6 - Pacotes estatisticos  ###########
#############################################################
getwd()


##-----------------------------------------------------
## apply
N = 10000 # Numero de replicas
n = 3000  # tamanho da amostra
x <- matrix(rnorm(N * n), nc = N) 
dim(x)

# definindo funÃ§Ã£o para calcular todas as mÃ©dias
f <- function(x){
  Ns = dim(x)[2]
  mx <- numeric(Ns) 
  for(i in 1:Ns) mx[i] <- mean(x[,i]) 
  mx 
} 

system.time(mx1 <- f(x)) # usando o for
system.time(mx2 <- apply(x, 2, mean)) # usando o apply
system.time(mx3 <- colMeans(x)) # outra alternativa

##-----------------------------------------------------
# sapply
fc = function(n, mu, sigma){
  x = rnorm(n, mu, sigma)
}
s = sapply(X=c(10,10,30,30), FUN =fc, mu=2, sigma=1)


##-----------------------------------------------------
## mapply

# Gerando amostras
fc = function(n, mu, sigma){
  x = rnorm(n, mu, sigma)
}
s = mapply(fc, n=c(10,10,30,30), mu=c(0,2,0,2), sigma=c(1,1,1,1))


# Gerando uma amostra apenas e calculando o desvio padrÃ£o
fc = function(n, mu, sigma){
  x = rnorm(n, mu, sigma);  s = sd(x)
}
s = mapply(fc, n=c(10,10,30,30), mu=c(0,2,0,2), sigma=c(1,1,1,1))

# Para gerar varias amostras e calcular a mÃ©dia
fc2 = function(n, mu, sigma){ replicate(100, fc(n, mu, sigma))}

s = mapply(fc2, n=c(10,10,30,30), mu=c(0,0,0,0), sigma=c(1,2,1,2))
boxplot(s)

##-----------------------------------------------------
## tapply
# warpbreaks[,-1] contem dois fatores 
tapply(warpbreaks$breaks, warpbreaks[,-1], sum)

##-----------------------------------------------------
## lapply
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
lapply(x, mean)
lapply(x, quantile, probs = 1:3/4)

##-----------------------------------------------------
## vapply
fc = function(n, mu, sigma){
  set.seed(1)
  x = rnorm(n, mu, sigma)
  media = mean(x)
}
sapply(X=c(10,10,30,30), FUN =fc, mu=2, sigma=1)
vapply(X=c(10,10,30,30), FUN =fc, mu=2, sigma=1, FUN.VALUE = 0)

##-----------------------------------------------------
## rapply

X <- list(list(am1 = rnorm(100), am2 = rexp(100)), am3=rbinom(10,5,0.5))
rapply(X, mean, how = "replace")
rapply(X, mean, how = "list")
rapply(X, mean, how = "unlist")


##-----------------------------------------------------

## Uma comparacao de tempo entre for, sapply e lapply
nc <- 1e3 
nr <- 200 

## Vendo varias formas de fazer a mesma coisa
set.seed(1)
res0 <- sapply(1:nc, function(x) rnorm(nr))
set.seed(1)
res1 <- NULL; for (i in 1:nc) res1 <- cbind(res1, rnorm(nr))
set.seed(1)
res2 <- matrix(NA, nc=nc, nr=nr); for (i in 1:nc)   res2[,i] <- rnorm(nr)
set.seed(1)
res3 <- do.call(cbind, lapply(1:nc, function(x) rnorm(nr)))
set.seed(1)
res4 <- replicate(nc, rnorm(nr))

all.equal(res0, res1)  ## deve ser TRUE 
all.equal(res1, res2) ## deve ser TRUE 
all.equal(res2, res3) ## deve ser TRUE 
all.equal(res3, res4) ## deve ser TRUE 

## removendo todos os objetos declarados anteriormente
rm(list=ls(all=TRUE))

nc <- 5e3
nr <- 200 

## com sapply 
set.seed(1) 
t0 <- system.time(res0 <- sapply(1:nc, function(x) rnorm(nr))) 
rm(res0)

## com for() usando o q a maioria de usuarios faz... 
set.seed(1) 
t1 <- system.time({res1 <- NULL; for (i in 1:nc) res1 <- cbind(res1, rnorm(nr))}) 
rm(res1) 

## com for() mais eficiente 
set.seed(1) 
t2 <- system.time({res2 <- matrix(NA, nc=nc, nr=nr); for (i in 1:nc)   res2[,i] <- rnorm(nr)}) 
rm(res2)

## com lapply() 
set.seed(1) 
t3 <- system.time(res3 <- do.call(cbind, lapply(1:nc, function(x) rnorm(nr)))) 
rm(res3) 

## com replicate 
set.seed(1) 
t4 <- system.time(res4 <- replicate(nc, rnorm(nr))) 
rm(res4) 

rbind(t0,t1,t2,t3,t4)


##-----------------------------------------------------

#### Blogs relacionados
# http://www.magesblog.com/2012/01/say-it-in-r-with-by-apply-and-friends.html
# https://analisereal.com/tag/split-apply-combine/



## Um pouco sobre integral Monte Carlo:

fc = function(x){
  y = x^2
  return(y)
}

## De forma exata: x^3/2 
(6^3)/3-(2^3)/3

## Resolvendo por um metodo computacional: quadratura adaptativa
integrate(f = fc, lower = 2, upper = 6)

## O que eh simulaÃ§Ã£o Monte Carlo? O que eh integral Monte Carlo
M = 100000
x = runif(M, 2, 6)
4*mean(x^2)

## A precisÃ£o desse metodo de integracao eh boa? Considere agora a funcao x^2+5*x^3
fc = function(x){
  y = x^2+5*x^3
  return(y)
}
## Valor confiavel
valor = integrate(f = fc, lower = 2, upper = 6)$value

fc2 = function(M){
  x = runif(M, 2, 6)
  return(4*mean(x^2+5*x^3))
}

Ms = 10^(1:7)
Is = sapply(X = Ms , FUN = fc2)

plot(log(Ms,base = 10), Is, type="b",pch=16,col=4)
abline(h=valor,col=2)

## Podemos calcular a area dentro do circulo unitario?

fc2 = function(M){
  x = runif(M)
  y = runif(M)
  return(mean((x^2+y^2)<=1))
}

Ms = 10^(1:7)
Is = sapply(X = Ms , FUN = fc2)
Is
## valor real: pi*r^2
pi*0.5^2

#-----------------------------------------------------------------------

## Definindo classe de objetos e comportamento de funÃ§Ãµes
# http://adv-r.had.co.nz/S3.html

x = rnorm(100)
x11()
plot (x)
class(x) = "Cristiano"
class(x)
plot(x)

## Agora a funcao plot tera um comportamento diferente para objetos do tipo "Cristiano"
plot.Cristiano <- function(x, main = "GrÃ¡fico da classe do cristiano"){
  boxplot(x, col=3, main = main)
} 

plot(x)
plot(x, main = " mudando")

methods(plot)
plot.function


#-------------------------------------------------------------------------------------
## Usando operadores como funcoes e definindo operadores

# Operadores tambÃ©m sÃ£o funÃ§Ãµes, porÃ©m podem ser utilizadas de duas formas diferentes:
2 + 2*(8/4)
'+'(2, '*'(2, '/'(8, 4)))
3 > 4
'>'(3, 4)


# O mesmo vale para outras funÃ§Ãµes bÃ¡sicas
i <- 1
x <- letters[1:3]
'if'(x[i] == "a", print("Sim!"), print("NÃ£o"))
'for'(i, x, print(i))
'['(x, 3)


# Criando operadores
# Para criar um operador basta criar uma funÃ§Ã£o entre percentuais â€˜%funcao%â€™
'%soma_mult%' <- function(x, y){
  z <- x + y
  result <- x*z
  return(result)
}

4 %soma_mult% 6
10 %soma_mult% 2

## Outro operador!!!
"%***%" <- function(x, y){
  x[2]+y[1]
}
1:2 %***% 5:8
1 %***% 5:8





