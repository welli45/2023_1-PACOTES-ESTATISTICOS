#############################################################
#######  Script da Aula 4 - Pacotes estatisticos  ###########
#############################################################
getwd()

rm(list = ls(all=T)) # para limpar tudo no ambiente
setwd("~/Documents/EST_R/PACOTES")
#-----------------------------------------------------------
# Funcao com uso de if
rL.ex <- function() { 
  cat("digite 0 se voce eh contra o impeachment da Dilma, 1 se eh a favor ou outro numero qualquer \n") 
  opiniao <- readLines(n = 1) 
  if (opiniao == 0) 
    cat("Alguem vai te chamar de Petralha qualquer hora!!!\n") 
  else if (opiniao == 1) cat("Alguem vai te chamar de Coxinha qualquer hora!!!\n") 
  else cat("Provavelmente voce ainda nao se decidiu quem eh pior, governo ou oposicao!!!\n") 
  return(invisible()) 
} 
rL.ex()


?# Exemplo com funcao recursiva: funcao fatorial 
  fatorial <- function(n){
    if(n==0){
      fat = 1
    } else{
      fat = n * fatorial(n-1)
    }
    return(fat)
  }

##----------------------------------------------------------
## ifelse()
## Suponha que queremos categorizar uma variavel em valores positivos e negativos
x = rnorm(20, 0, 2)
y = ifelse(x<=0,0,1)
cbind(x,y)

#-----------------------------------------------------------
## switch
centre <- function(x, type) {
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}
x <- rnorm(100)
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

#-----------------------------------------------------------
# Operadores
x = 1:10
x==5
(x!=5)
(x<5)&(x>2)
(x<5)&&(x>2)
(x<5)|(x>7)
(x<5)||(x>7)


#########################################################
#########################################################
## Implementacao da mesma funcao com for, while e repeat


for(i in 1:10){
  print(i)
}

for(i in c(1,5,1,3,2,5)){
  print(i)
}

## A funcao a ser implementada gera amostras com tamanho 
## do numero do banco de dados e calcula a media arredondando
## para 3 casas decimais

f1 <- function(n) { 
  medias <- numeric(n) 
  for (i in 1:n) { 
    am <- rnorm(i) 
    medias[i] <- round(mean(am), dig = 3) 
  } 
  return(medias) 
} 

## Fixar a semente de geracao faz com que as amostras geradas sejam as mesmas 
set.seed(283) 
f1(10)

## Agora vamos executar a mesma tarefa com while()

f2 <- function(n) { 
  medias <- numeric(n) 
  i <- 1 
  while (i <= n) { 
    am <- rnorm(i) 
    medias[i] <- round(mean(am), dig = 3) 
    i <- i + 1 
  } 
  return(medias) 
} 

set.seed(283) 
f2(10)

# E finalmente a mesma tarefa com repeat()

f3 <- function(n) { 
  medias <- numeric(n) 
  i <- 1 
  repeat { 
    am <- rnorm(i) 
    medias[i] <- round(mean(am), dig = 3) 
    if (i == n) break 
    i <- i + 1 
  } 
  return(medias) 
} 

set.seed(283) 
f3(10)

## Nas solucoes acima as amostras foram usadas para calcular as medias e depois descartadas. 
## Suponha agora que queremos preservar e retornar tambem os dados simulados. 
## Para ilustrar vamos mostrar como fazer isto modificando um pouco a primeira funcao.

f1a <- function(n) { 
  res <- list() 
  res$amostras <- list() 
  res$medias <- numeric(n) 
  for (i in 1:n) { 
    res$amostras[[i]] <- rnorm(i) 
    res$medias[i] <- round(mean(res$amostras[[i]]), dig = 3) 
  } 
  return(res) 
} 

set.seed(283) 
ap <- f1a(4) 
names(ap)
ap



## Vamos agora ver uma outra modificacao. 
## Nas funcoes acima geravamos amostras com tamanhos sequenciais com incremento de 1 elemento no tamanho da amostra.
## A funcao a seguir mostra como gerar amostras de tamanhos especificados pelo usuario e para isto toma como argumento um vetor de tamanhos de amostra.

f5 <- function(ns) { 
  medias <- numeric(length(ns)) 
  j <- 1 
  for (i in ns) { 
    am <- rnorm(i) 
    medias[j] <- round(mean(am), dig = 3) 
    j <- j + 1 
  } 
  return(medias) 
} 

set.seed(231) 
f5(c(2, 5, 8, 10))


#########################################################
#########################################################
## Tempo computacional
## switch e if
test1 <- function(type) {
  switch(type,
         mean = 1,
         median = 2,
         trimmed = 3)
}

test2 <- function(type) {
  if (type == "mean") 1
  else if (type == "median") 2
  else if (type == "trimmed") 3
}

system.time( for(i in 1:1e6) test1('mean') ) 
system.time( for(i in 1:1e6) test2('mean') ) 
system.time( for(i in 1:1e6) test1('trimmed') ) 
system.time( for(i in 1:1e6) test2('trimmed') ) 

#########################################################
#########################################################
## microbenchmark
# Exemplo: funcao fatorial 
install.packages("microbenchmark")
require(microbenchmark)

factorial(5)

fatorial <- function(n){
  if(n==0){
    fat = 1
  } else{
    fat = n * fatorial(n-1)
  }
  return(fat)
}

## verificando a funcao
sapply(0:5,fatorial)
all.equal(factorial(10), fatorial(10))

## Comparando o tempo computacional
microbenchmark(factorial(10), fatorial(10))
