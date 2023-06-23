#===---===---===---===---===---===---===---===---===---===---===---===---===---
########## Pacotes Estatísticos - 2023/1 - Lista de exercícios 1 ###############
## Resolução da lista 1 

##  Aluno(a) 1: Wellington Santos Souza
##  Matricula 1: 2019012213

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 1 Mostre comandos que podem ser usados para criar e guardar os objetos 
# a seguir: (sem  digitar diretamente todos os dados)

# a) O vetor com a sequência de valores ( 8, 7, 6, 5, ..., 0, -1, -2);

q1a <- seq(8,-2)
q1a

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# b) O vetor com a sequencia de valores (2, 4, 6, 8, 10, ..., 98, 100);

q1b <- seq(2,100, by=2)
q1b

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# c) O vetor ( 3, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, ...,-10, -10, -10);

q1c <- (rep(seq(3,-10),3, each = 3))
q1c

?rep

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# d) O vetor de elementos repetidos (2, 4, 3, 2, 4, 3, 2, 4, 3, 2, 4, 3);

q1d <- rep(c(2,4,3),4)
q1d

#===---===---===---===---===---===---===---===---===---===---===---===---===---
# e) O vetor lógico indicando quais elementos do vetor no item d) são maiores do 
# que 3, isto é, o vetor contém TRUE nas posições onde o número é maior do que 3. Use
# comparação para construir os vetor

q1e <- (q1d > 3)
q1e

# f) O vetor de palavras (Cachorro, Gato, Gato, Coelho, Tamanduá, Tamanduá, 
# Cachorro, Coelho, Coelho)

q1f <- c('Cachorro',rep('Gato',2),'Coelho',rep('Tamanduá',2),'Cachorro',rep('Coelho',2))
q1f

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 2: Escreva uma expressão do R para retornar as posições que contém o 
# número 3 no vetor 

x = c(1, 3, 6, 7, 3, 7, 8, 9, 3, 7, 2)

q2 <- which(x==3)
q2

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 3 A função sum(x) retorna a soma dos elementos do vetor x. 
# A expressão z = rep(x, 10) faz o vetor z igual a uma sequência de 10 vetores x. 
# Use estas e outras funções para calcular o resultado dos 1000 primeiros termos 
# das séries:

# a) 1 + 1/2 + 1/3 + 1/4 + . . .

q3a <- sum((1/(1:1000)))
q3a

# b) 1 − 1/2 + 1/3 − 1/4 + 1/5 − 1/6 + . . .

q3b <- sum((1/seq(1,1000,2)),(-1/seq(2,1000,2)))
q3b

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 4: Descreva a diferença entre is.infinite(x) e !is.infinite(x).

q4 <- 1:4

is.finite(q4)

!is.infinite(q4)

# Resposta: O primeiro código (is.finite(q4)) tem como resultado todos o valores 
# tendo resultado TRUE, assim como no segundo (!is.infinite(q4)). Então 
# a diferença reside no teste lógico, isto é, o primeiro pergunta se os valores 
# do vetor x4 é finito e o segundo se os valores não são infinitos. 

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 5: Pesquise funções para converter um double em um integer.

# cria o vetor
q5 <- c(1.2,3.5)

# teste lógico para verificar se é double
is.double(q5)

# converte o vetor para inteiro
q5conv <- as.integer(q5)

# faz o teste lógico
is.integer(q5conv)

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 6: O que mean(is.na(x)) lhe diz sobre um vetor x? E sum(!is.infinite(x))?

q6 <- c(1:5,rep(NA,3),23:29,NA,NA)

mean(is.na(q6))

# A função mean(is.na(x)) calcula a média de valores NA no vetor X.

sum(!is.infinite(q6))

# A função sum(!is.infinite(x)) calcula a soma dos valores que não são infinitos 
# no vetor X.   

#===---===---===---===---===---===---===---===---===---===---===---===---===---

#  Questão 7: Por que x[-which(x > 0)] não é o mesmo que x[x <= 0]?

q7 <- -2:5

q7[-which(q7 > 0)]

q7[q7<=0]

# Resposta: a primeira (x[-which(x > 0)]), pede para retornar os valores do vetor exceto
# os valores maiores que 0. Já a segunda (x[x <= 0]), pede para retornar os valores menores 
# ou iguais a 0.

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# 8. O que acontece quando tentamos tirar um subconjunto do vetor utilizando uma 
# posição com número maior do que o tamanho do vetor?

q8 <- 10:100
q8[120]

# Resposta: O R retorna um valor NA (Not Available). 

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# 9. Explique o que o R faz nos seguintes códigos:

# a) rep(1, 10) + 5

# Reesposta: o R retornará uma repetição de 10 números 6. Pois, o código diz, 
# repita o número 1, 10 vezes. Mas temos uma soma logo em seguida. E o R somará
# um 5 a cada 1, criando assim a repetição descrita. 

# b) rep(1, 10) + c(1, 2)

# Resposta: O R retornará uma repetição de (2 e 3) 10 vezes. Pois, o código diz, 
# repita a o número 1, 10 vezes. Mas temos uma soma logo em seguida. E o R somará
# 1 ao 1º número e 2 ao 2º, criando assim a repetição descrita. 

# c) rep(1, 10) + c(1, 2, 3)

# Resposta: retorna uma mensagem de aviso: o comprimento do objeto mais longo 
# não é múltiplo do comprimento do objeto mais curto.Essa mensagem de aviso 
# ocorre quando tentamos adicionar dois vetores de comprimentos diferentes. 
# Nesse caso, estamos tentando somar um vetor de 10 números 1 com um vetor de 
# três elementos.

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# 10. Qual é a classe dos vetores resultantes dos códigos abaixo:
  
# a) 
y <- c(1.7, "a")

class(y)

# No R, quando combinamos elementos de diferentes tipos em um vetor, o R tenta 
# fazer uma coerção de tipos para que todos os elementos do vetor tenham o mesmo 
# tipo. Neste caso, como o vetor y contém um valor numérico 1.7 e um valor de 
# caractere "a", o R faz uma coerção para transformar o valor numérico em 
# caractere, resultando em um vetor de caracteres.

# Resposta: character

# b) 
y <- c(TRUE, 2)

class(y)

# No R, quando combinamos elementos de diferentes tipos em um vetor, o R tenta 
# fazer uma coerção de tipos para que todos os elementos do vetor tenham o mesmo 
# tipo. Neste caso, como o vetor y contém um valor lógico TRUE e um valor 
# numérico 2, o R faz uma coerção para transformar o valor lógico em numérico, 
# resultando em um vetor numérico.

# Resposta: numeric

# c) 
y <- c("a", TRUE)

class(y)

# No R, quando tentamos criar um vetor contendo valores de diferentes tipos, o R tenta
# fazer uma coerção de tipos para que todos os elementos do vetor tenham o 
# mesmo tipo. No caso do vetor y <- c("a", TRUE), o R faz a coerção para o 
# tipo mais geral, que é o tipo de caractere.
# Resposta: numeric

# Pesquise a explicação para estes resultados.


