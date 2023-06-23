#############################################################
#######  Script da Aula 1 - Pacotes estatisticos  ###########
#############################################################
# An Introduction to R - CRAN ----
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html
###  Algumas demonstracoes sobre funcoes e graficos do R
demo()  # Vendo quais as demonstracoes disponiveis

demo(graphics) # Demonstracao do graphics
demo(image)
demo(persp)

#============================================================
### Funcoes

lm # Vendo o conteudo da funcao lm - comando sem os parenteses
max 
mean
sqrt(5)
log(1)
help(log) # Olhando o help da funcao log


#============================================================
#============================================================
### Vetores

# Criando um vetor numerico
c(5,3,4) # Desta forma o vetor eh apenas impresso na tela
a = c(5,3,4)  # atribuindo ao objeto a
a 

b <- c(5,3,4,3,6,54,5) # outra forma de atribuir ao objeto, sem usar o "="
b

a = scan() # outra forma. Para digitar os valores no console
5
6
7


# Para acessar uma posicao do vetor usamos colchetes
b
b[5]
b[c(3,6)] # apresenta o 3º e 0 6º elementos do vetor

# excluir alguma entrada do vetor
b[-2]

# Podemos juntar dois vetores
d = c(a,b)

#============================================================
# criando um vetor de caracteres
d = c("x1","x2","x3")
d 

# outro exemplo
nome<-c("Maria","Pedro","Joao","Rosa")

# mais um exemplo
let5 <- letters[1:5] # letras minúsculas de "a" a "e"
let5
let10 <- LETTERS[11:20] # letras maiúsculas de "K" a "T"
let10

# outro
paste("T", 1:10,sep="") #vetor caracteres T com índices de 1 a 10

#============================================================
# Fator - Usado com variaveis categoricas

frutas<-rep(c("laranja","banana","limao","jaboticaba"),times=5)
frutas <-factor(frutas) # converte os nomes em categorias (factor)
frutas

citricas<-frutas # copia o objeto frutas para o objeto citricas
levels(citricas) # mostra os objetos de cítricas
levels(citricas)<-c("nao","nao","sim","sim") #modifica os níveis dos fatores
citricas # mostra o fator modificado

#============================================================
# criando um vetor logico
e = c(TRUE, FALSE, TRUE)
e

idade <- c (23 , 21.8 , 26.1 , 27)
idade <= 25 ## vetor logico criado em uma comparacao
logico = (idade <= 25) # vetor lógico armazenado 

peso <- c(78,65,58,60)
peso[idade <= 25] # O vetor peso comparado com vetor idade (mesma posição)
#[1] 78 65

#transformar um vetor logico em vetor com 0 e 1
logico * 1
as.numeric(logico)

sum(logico*1) # Uma forma de contar quantos TRUES existem no vetor

#============================================================
# colocando nomes nas posicoes de um vetor
names(a)= c("x1","x2","x3") 

x = c(a = 1, b = 5) # de outra forma
x

#============================================================
# criando um vetor com dados faltantes
b = c(1,3,3,5,6,NA,8,9,4)

#============================================================
# Operacoes com vetores
idade <- c (23 , 21.8 , 26.1 , 27)
idade * 10
idade - 10

distidade<-idade - mean(idade)
distidade

#============================================================
## Criando vetores formados por sequencias regulares
1:10
3:10

a = seq(0,1,by=0.1) # sequencia de 0 até 1 em passos de 0.1
a 

length(a)
is.numeric(a)
is.vector(a)

seq(1,50,length.out=11) #sequencia de 1 até 50 com 11 elementos igualmente distribuídos
rep(5,10)

## Podemos combinar essas funcoes
?rep
rep(1:3, each = 3) 
# [1] 1 1 1 2 2 2 3 3 3
rep(1:3, times = 3)
# [1] 1 2 3 1 2 3 1 2 3
#============================================================
# Outras duas funcoes uteis

sort(idade) # ordena os valores em ordem crescente
rank(idade) # atribui posicões aos elementos
rank(max(idade)) #informa a posição do valor máximo do vetor

rev(idade) # gera a versão reversa do argumento. não eficiente p/ obter ordem decrescente
rank(rev(idade))

which(idade > 23) # posições nas quais idade > 23
which.max(c(1,2,5,3,3)) ## Posicao onde esta maximo
max(c(1,2,5,3,3)) ## calcula o maximo
a = seq(0,13,by=0.1)
length(a) ## tamanho do vetor
is.numeric(a) # verifica se é numérico
is.vector(a) ## verifica se eh um vetor

#============================================================
#============================================================
### Matrizes

freq<-c(18, 02, 04, 26)
M <-matrix(freq, ncol=2)
M
#     [,1] [,2]
#[1,]   18    4
#[2,]    2   26

M <-matrix(c(18, 02, 04, 26), ncol=2) # de outra forma. default: por coluna
M <-matrix(c(18, 02, 04, 26), ncol=2, byrow=TRUE) # por linha
M
#     [,1] [,2]
#[1,]   18    2
#[2,]    4   26

# criando uma matriz com zeros
M1 <-matrix(0,ncol=3,nrow = 2)
M1
#     [,1] [,2] [,3]
#[1,]    0    0    0
#[2,]    0    0    0
dim(M1)
length(M1)

# criando uma matriz diagonal
diag(3) # matriz identidade
#     [,1] [,2] [,3]
#[1,]    1    0    0
#[2,]    0    1    0
#[3,]    0    0    1
diag(5,3) # Matriz diagonal com valor 5
#     [,1] [,2] [,3]
#[1,]    5    0    0
#[2,]    0    5    0
#[3,]    0    0    5

# criando uma matriz apartir de vetores
cbind(1:4,9:12) # concatena colunas
rbind(1:4,9:12) # concatena linhas

# transformando um vetor em matriz coluna
as.matrix(1:5)
#     [,1]
#[1,]    1
#[2,]    2
#[3,]    3
#[4,]    4
#[5,]    5

# operacoes matriciais
M1 = diag(2,3)
M2 = cbind(1:3,4:6,7:9)
V1 = 1:3
V2 = as.matrix(V1)

M1
#     [,1] [,2] [,3]
#[1,]    2    0    0
#[2,]    0    2    0
#[3,]    0    0    2
M2
#     [,1] [,2] [,3]
#[1,]    1    4    7
#[2,]    2    5    8
#[3,]    3    6    9
V1
#[1] 1 2 3
V2
#     [,1]
#[1,]    1
#[2,]    2
#[3,]    3

M1 + M2
#     [,1] [,2] [,3]
#[1,]    3    4    7
#[2,]    2    7    8
#[3,]    3    6   11

# Os sinais ∗ e / fazem operações ponto a ponto, 
##e para isso as matrizes envolvidas devem ter a mesma dimensão

#IMPORTANTE: Para multiplicação matricial você deve usar  %∗%

M1 * M2
#     [,1] [,2] [,3]
#[1,]    2    0    0
#[2,]    0   10    0
#[3,]    0    0   18

M1 %*% M2 # multiplica TODOS os elementos da matriz M1 pelo valor da diagonal em M2
#     [,1] [,2] [,3]
#[1,]    2    8   14
#[2,]    4   10   16
#[3,]    6   12   18

solve() 
# to solve a linear system of equations, or equivalently, solve for X in: A X = B
# where A is a square matrix, and X, B are matrices or vectors 
## (which are treated as 1-column matrices), and the R syntax is: X <- solve(A,B)
solve(M1) 
#     [,1] [,2] [,3]
#[1,]  0.5  0.0  0.0
#[2,]  0.0  0.5  0.0
#[3,]  0.0  0.0  0.5

solve(M2)
# Error in solve.default(M2) : 
# Lapack routine dgesv: system is exactly singular: U[3,3] = 0

t(M2) # calcula matriz transposta

M2 %*% V1 #(3x3) %*% (3x1) = (3x1)
#     [,1]
#[1,]   30
#[2,]   36
#[3,]   42

M2 %*% V2 #(3x3) %*% (3x1) = (3x1)

M2 + V1 # soma a matriz coluna V1 a todas as colunas de M2, ponto a ponto
#     [,1] [,2] [,3]
#[1,]    2    5    8
#[2,]    4    7   10
#[3,]    6    9   12

M1>M2 #compara os elementos da matriz
M2>V1

# Atribuindo nomes
colnames(M2) = c("a","b","c")
rownames(M2) = c("d","e","f")

sum(M2) # soma de todos os elementos da matriz
colSums(M2) #soma dos elementos de cada coluna
rowSums(M2) # soma dos elementos de cada linha

# Usando matriz para fazer uma tabela
freq<-c(18, 02, 04, 26)
M<-matrix(freq, ncol = 2, byrow = TRUE, dimnames = list(c("doente","nao doente"),
                                                        c("positivo","negativo")))
M
#           positivo negativo
#doente           18        2
#nao doente        4       26

M[1,1]
M[1,]  #retorna a primeira linha da matriz
M[,2]  #retorna a segunda coluna da matriz

## array
ar1 <- array(1:24, dim = c(3, 4, 2)) # gera seq 24 numeros para 2 matrizes 3x4
ar1
#, , 1

#[,1] [,2] [,3] [,4]
#[1,]    1    4    7   10
#[2,]    2    5    8   11
#[3,]    3    6    9   12

#, , 2

#[,1] [,2] [,3] [,4]
#[1,]   13   16   19   22
#[2,]   14   17   20   23
#[3,]   15   18   21   24

class(ar1)
#============================================================
#============================================================
### Data.frame
dados <-  data.frame(idade=c(24,30,54,31,19),salario=c(2000,3000,1700,500,550),
                     estadocivil= c("solteiro","casado","casado","solteiro","casado"))

dados
head(dados) # apresenta os 6 primeiros dados da tabela
#  idade salario estadocivil
#1    24    2000    solteiro
#2    30    3000      casado
#3    54    1700      casado
#4    31     500    solteiro
#5    19     550      casado

names(dados) # apresenta o nome das variáveis do dataframe
dados[1,] # mostra os dados da primeira linha
dados[,1] # mostra os dados da primeira coluna

dados$idade
dados$salario
dados$estadocivil

mean(dados$idade)
mean(dados$salario)
by(dados$salario, dados$estadocivil, mean) # média do salário por categoria de estado civil

## um dataframe pode ser editado usando as funcoes fix e edit
edit(dados)
fix(dados)

#============================================================
#============================================================
### Lista
lis1 <- list(A = 1:10, B = "THIS IS A MESSAGE", C = matrix(1:9, ncol = 3))
lis1
lis1[1] # apresenta o nome da 1ª lista e o conteúdo
mode(lis1[1])# diz o modo em que está o 1º objeto da lista
#[1] "list"
lis1[[1]] # apresenta os elementos da 1ª lista
mode(lis1[[1]])
#[1] "numeric"

lis1[[3]]
#     [,1] [,2] [,3]
#[1,]    1    4    7
#[2,]    2    5    8
#[3,]    3    6    9
#============================================================
#============================================================
### Criar uma funcao
fc = function(a, b){
  c = a^b+b
  return(c)	
}

fc(1,2)
fc(2,3)

# Outra funcao - Note que nao coloquei o return
fc2 = function(a, b){
  print(paste("a:", a))
  print(paste("b:", b))
  c1 = a^b+b
  d1 = a+b
}

fc2(1,2)
a3 = fc2(2,3)
a3
c1 ## Objeto foi definido apenas dentro da funcao, por isso dara erro


# Mais uma funcao construida - usando um objeto definido globalmente
d = 2
fc3 = function(a){
  c = a^d+d
  return(c)	
}

fc3(4) ## objeto d eh definido globalmente e por isso ele existe dentro da funcao mesmo 
## que nos nao o colocamos como argumento


## definindo variavel global de dentro da funcao
fc4 = function(a, b){
  c1 <<- a^b+b ## com isso o c1 passa a existir fora da funcao criada
  d1 = a+b
  return(d1)
}

fc4(2,2)
c1