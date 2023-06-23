#===---===---===---===---===---===---===---===---===---===---===---===---===---
## Resolução da lista X (mude para o número adequado)

##  Aluno(a) 1: Wellington Santos SOuza
##  Matricula 1: 2019012213

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# pacotes utilizados
if(!require(tidyverse)){install.packages("tidyverse")};library(tidyverse)

# 1. Mostre comandos que podem ser usados para criar e guardar os objetos a seguir:

# a) Um vetor de fatores com as respostas (Cachorro, Gato, Gato, Coelho, Tamanduá,
# Tamanduá, Cachorro, Coelho, Coelho). Defina os níveis do fator para (Tamanduá,
# Gato, Coelho, Cachorro) e rode o código barplot(table(nome_do_vetor)).

# RESPOSTA:

a1 <- c('Cachorro', 'Gato', 'Gato', 'Coelho', 'Tamanduá',
       'Tamanduá', 'Cachorro', 'Coelho', 'Coelho')

barplot(table(a1))

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# b) Uma matriz com 20 linhas em que a primeira coluna contém os primeiros 20 números
# pares (2, 4, 6, ...), a segunda coluna contém apenas o número 1 em todas as linhas
# e a terceira coluna contém os primeiros 20 números ímpares (1, 3, 5, ...). Nomeie as
# colunas desta matriz.

# RESPOSTA:

b1 <- matrix(data=c(
  seq(2,40,2),
  rep(1,20),
  seq(1,40,2)
),nrow = 20)

colnames(b1) <- c("numPar","repNum1","numImpar")

b1

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# c) Construa um dataframe com 10 linhas em que a primeira coluna representa uma
# variável discreta, a segunda coluna representa uma variável categórica e a terceira
# coluna representa uma variável quantitativa contínua. Use dados fictícios.

# RESPOSTA

c1 <- data.frame(
  numFilhos = c(2,3,2,1,2,3,1,7,3,6),
  Genero = c('Não Binário','M','F','Não Binário','M','F','M','F','M','F'),
  rendaPerCap = c(sample(seq(1535.1,1545.9,0.21),size = 10, replace = T))
)

str(c1)

# Questão 2 Escreva um código para criar uma matriz A e a partir dela obter 
# os objetos a seguir:

A <- matrix(data=c(
  seq(2,20,2),
  rep(1352,10),
  seq(1,20,2)
),nrow = 10)

A

# Um objeto denominado a com a primeira coluna da matriz A;

a <- A[,1]
a
# Um objeto denominado B retirando apenas a primeira coluna da matriz A;

B <- A[,-1]
B

# Um objeto denominado C sendo a matriz transposta de B;

C <- t(B)
C

# Um objeto denominado D com o resultado a multiplicação matricial de C por B;

D <- C%*%B
D

# Um objeto E representando a matriz inversa de D;

E <- solve(D)
E

# Um objeto F com o resultado de D*C*a (multiplicação matricial);

F <- D%*%C%*%a
F

# Um objeto G com o resultado de a − B*F;

G <- a-B%*%F
G

# O objeto k, calculado como k = n − p, com n sendo o número de linhas e p sendo o
# número de colunas menos 1.

k <- nrow(A)-(ncol(A)-1)
k

# Um objeto H com o resultado de (GtG)/k.

H <- (t(G)%*%G)/k
H

# Uma lista com os objetos E, F, G e H.

lista <- list(E,F,G,H)
lista

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 3 Construa uma lista (e guarde em um objeto) contendo o vetor da questão 1 a), a matriz
# da questão 1 b), o dataframe da questão 1 c) e o nome de três cidades. Usando o objeto
# construído, acesse o primeiro elemento da lista. Acesse o segundo elemento da lista e
# obtenha a média dos valores em cada linha da matriz.

# RESPOSTA

# lista
listaq3 <- list(a1,b1,c1,c('Jaborandi-BA','Cocos-BA','Coribe-BA'))

# primeiro elemento
listaq3[[1]]

# segundo elemento
listaq3[[2]]

rowMeans(listaq3[[2]])
#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 4. Construa um dataframe com uma tabela com três colunas: x, x^2
# e exp(x), com x variando de 0 a 50. Construa um tibble com as mesmas informações.

# dataframe

set.seed(123)

x = sample(seq(0,50,1),10)

xqua = (x^2)

expx = exp(x)

dfq4 <- data.frame(
  x,xqua,expx
)


dfq4

# tibble

set.seed(123)

tblq4 <- tibble::tibble(
  x = sample(seq(0,50,1),10),
  xqua = (x^2),
  expx = exp(x)
)

tblq4
#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 5. Utilize o comando “subset” para selecionar os pesos e tempos dos frangos que tiveram a
# dieta 2 no banco de dados “ChickWeight” disponível no R. Utilize novamente o “subset”
# para selecionar pesos no tempo igual a 2 dos frangos que tiveram a dieta 2 e calcule a
# média destes pesos

data(ChickWeight)

#  dieta igual a 2 

dieta <- subset(ChickWeight,Diet == 2)
dieta

# pesos no tempo igual a 2 dos frangos que tiveram a dieta 2
pesoDieta <- subset(ChickWeight,Time == 2 & Diet == 2)

# média dos pesos
mean(pesoDieta$weight)

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# Questão 6. O que acontece se você executar o código a = tibble(x = 1, y = list(g = 5, h= 5)) após
# carregar o pacote tidyverse? Como acessar os valores dos objetos g e h criados dentro do
# tibble?

# rodando o código
a = tibble(x = 1, y = list(g = 5, h= 5))

# acessando os valores de g
a$y[[1]]

# acessando os valores de h
a$y[[2]]

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 7. Tente fazer um tibble que tenha colunas com comprimentos diferentes. O que acontece?
# E com um dataframe? Use colunas de tamanho 2 e 10 e, posteriormente, colunas de
# tamanho 3 e 10


# Criando um tibble com colunas de tamanho 2 e 10
meu_tibble <- tibble(coluna1 = c(1, 2),
                     coluna2 = rnorm(10),
                     coluna = rnorm(10))
# 3 e 10
meu_tibble2 <- tibble(coluna1 = c(1, 2,3),
                     coluna2 = rnorm(10),
                     coluna = rnorm(10))

# Ocorre um erro, pois as colunas não tem o mesmo tamanho. 
# Ao criar uma tibble, todas as colunas devem ter o mesmo número de elementos.

# Criando um data frame com colunas de tamanho 3 e 10
meu_dataframe <- data.frame(coluna1 = c(1, 2, 3),
                            coluna2 = c("a", "b", "c"),
                            coluna3 = rnorm(10),
                            coluna4 = rnorm(10))
# 2 e 10
meu_dataframe2 <- data.frame(coluna1 = c(1, 2),
                            coluna2 = c("a", "b"),
                            coluna3 = rnorm(10),
                            coluna4 = rnorm(10))

# Ocorre o mesmo erro do tibble, pois aqui há uma tentativa de combinar colunas
# de tamanhos diferentes.

#===---===---===---===---===---===---===---===---===---===---===---===---===---



