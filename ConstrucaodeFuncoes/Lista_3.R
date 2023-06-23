#===---===---===---===---===---===---===---===---===---===---===---===---===---
## Resolução da lista 3 

##  Aluno(a) 1: Wellington Santos Souza
##  Matricula 1: 2019012213


#===---===---===---===---===---===---===---===---===---===---===---===---===---


# Questão 1: --------------------------------------------------------------

x <- runif(20)
y <- rnorm(20, 0.5 + 2*x, 1)
matriz <- cbind(y, 1, x)

maQ1 <- function(A){
  Y = A[,1]
  B = A[,-1]
  C = (solve(t(B)%*%B))%*%(t(B)%*%Y)
  D = Y-(B%*%C)
  k = nrow(A)-(ncol(A)-1)
  E = (t(Y-(B%*%C))%*%(Y-(B%*%C)))/k
  print(list(C,D,E))
}

maQ1(matriz)


# Questão 2: --------------------------------------------------------------

variancia_amostral <- function(x, na.rm = TRUE) {
  if (!is.numeric(x)) {
    stop("O argumento x deve ser numérico.")
  }
  
  if (na.rm) {
    x <- x[!is.na(x)]
  } else if (any(is.na(x))) {
    stop("O vetor x contém valores ausentes.")
  }
  
  n <- length(x)
  if (n < 2) {
    stop("O vetor deve ter pelo menos dois elementos.")
  }
  
  var <- sum((x - mean(x))^2) / (n - 1)
  return(var)
}

x <- rnorm(30,45,3)

variancia_amostral(x)
# Questão 3: --------------------------------------------------------------

both_na <- function(x,y){
  if(length(x)!=length(y)){
    print("Os vetores não tem o mesmo tamanho")
  }else{
  list(which(is.na(x)),which(is.na(y)))
  }}

x <- c(1:12,NA,NA,NA)
y <- c(NA,11:23,NA)

both_na(x,y)


# Questão 4 ---------------------------------------------------------------

x <- rnorm(100)

categ <- function(x){
  ifelse(x < -1, 0, ifelse(x > 1, 2, 1))
}

categ(x)

ceteg2 <- function(x){
  cut(x, breaks=c(-Inf, -1, 1, Inf), labels=c(0, 1, 2))
}
ceteg2(x)


# Questão 5 ---------------------------------------------------------------

medias <- function(x, tipo){
  media = switch(tipo,
                 media = mean(x),
                 mediana = median(x),
                 mediaGeo =  prod(x)^(1/length(x)),
                 mediaHarm = length(x)/sum(1/x))
  print(media)
}

x <- rnorm(190)

medias(x, 'mediaHarm')


# Questão 6 ---------------------------------------------------------------

primCaracter <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
}

f1('Galo',"a")

excetoUltimo <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
}

f2(c(24,3,3,6,7))

numVetFirst <- function(x, y) {
  rep(y, length.out = length(x))
}


# Questão 7: --------------------------------------------------------------

fizzbuzz <- function(x){
  ifelse(x%%3 == 0, 'fizz', ifelse(x%%5 == 0, 'buzz', x))
}

fizzbuzz(7)

# Questão 8: --------------------------------------------------------------

# Resposta: diz sobre os métodos de cálculo da função cor(). O valor usado como
# padrão é o método de PEARSON
#===---===---===---===---===---===---===---===---===---===---===---===---===---




