#############################################################
#######  Script da Aula 2 - Pacotes estatisticos  ###########
#############################################################

# Vendo qual eh o diretorio de trabalho
getwd()

# Mude o diretorio para a pasta mais adequada
setwd("~/Documents/EST_R/PACOTES ESTATÍSTICOS")

##===========================================================
## Analise Descritiva e Exploratoria de Dados - variaveis qualitativas

#head() - Mostra as primeiras 6 linhas.
#tail() - Mostra as últimas 6 linhas.
#dim() - Número de linhas e de colunas.
#names() - Os nomes das colunas (variáveis).
#str() - Estrutura do data.frame. Mostra, entre outras coisas, as classes de cada coluna.
#cbind() - Acopla duas tabelas lado a lado.
#rbind() - Empilha duas tabelas.


# Manipulacao de banco de dados
milsa <- read.table("http://www.leg.ufpr.br/~paulojus/dados/milsa.dat", head = T) 
View(milsa)

# para poder acessar depois sem usar internet
write.table(milsa,"milsa.txt",row.names =FALSE)
# chamando o banco de dados arquivado em txt:
milsa <- read.csv("milsa.txt", header = TRUE, sep = " ")

mode(milsa) #lista

?transform

## Transformando um banco de dados
milsa <- transform(milsa, 
                   civil = factor(civil, 
                                  label = c("solteiro", "casado"), 
                                  levels = 1:2), 
                   instrucao = factor(instrucao, 
                                      label = c("1oGrau","2oGrau", "Superior"),
                                      lev = 1:3, ord = T), 
                   regiao = factor(regiao,
                                   label = c("capital", "interior", "outro"),
                                   lev = c(2, 1, 3))) 

milsa <- transform(milsa, 
                   idade = ano + mes/12) # cria variável idade

names(milsa) # nome das variáveis

#------------------------------------------------------------------------------------------
## Tabelas e graficos de frequencias para uma variavel
attach(milsa)
t1 <- table(civil) 
t1 
prop.table(t1)
round(prop.table(t1), 2)


# Graficos
barplot(t1)
pie(t1)

# ou
plot(civil)
plot(ano)
plot(factor(ano)) ## Note que a funcao plot retorna diferentes resultados dependendo do tipo do objeto.

# Tem como melhorar este grafico?
x11() ## Ou win.graph()
barplot(t1, main="Distribuicao segundo Estado civil", ylab= "Frequencia", xlab="Estado civil",col ="blue") 

x11()
pie(t1, labels = paste(c("casado - ","solteiro - "), round(prop.table(t1)*100,2), "%", sep=""),
    main="Distribuicao segundo estado civil", col = c("blue","red")) 

?barplot

# Eh possivel plotar dos dois graficos na mesma janela grafica?
x11()
par(mfrow = c(1,2), oma = (4:1))
barplot(t1, main="Estado civil", ylab= "Frequencia", xlab="Estado civil",col ="red",col.axis="blue") 
pie(t1, labels = paste(c("casado - ","solteiro - "), round(prop.table(t1)*100,2), "%", sep=""),
    main="Estado civil", col = c("blue","red"))

# Quais parametros graficos podemos mudar
?par

# Quais cores podemos usar
colours()
pie(rep(1, 12), col = rainbow(12))
pie(rep(1, 12), col = heat.colors(12))
?palette
?rainbow


# Como salvar um grafico? Clicando em salvar ou usando o comando abaixo
savePlot(filename = "NOME",type =  "pdf") 

detach(milsa)


#------------------------------------------------------------------------------------------
## Tabelas de contingencia - sem usar o attach agora
mode(milsa)
t1 <- table(milsa[,c(2, 3)]) #pos2==civil(linha) e pos3==instrucao(coluna)
t1
#          instrucao
#civil      1oGrau 2oGrau Superior
#solteiro      7      6        3
#casado        5     12        3

## 
t1f <- ftable(milsa[c(2, 3)]) # ftable: 'flat' contigency tables
t1f
#         instrucao 1oGrau 2oGrau Superior
#civil                                    
#solteiro                7      6        3
#casado                  5     12        3

# simplify2array() is the utility called from sapply() when simplify is not false 
sapply(list(t1, t1f), class) # informa as classes de t1 e t1f
sapply(list(t1, t1f), is.matrix) #diz de t1 e t1f são matrizes (TRUE or FALSE)
sapply(list(t1, t1f), is.array) #diz de t1 e t1f são array (TRUE or FALSE)

dimnames(t1) # dimensão das variáveis da tabela t1. lista as categorias das variáveis
#$civil
#[1] "solteiro" "casado"  

#$instrucao
#[1] "1oGrau"   "2oGrau"   "Superior"

t1 <- table(milsa[c(2, 3)], dnn = c("Estado Civil", "Nivel de Instrucao")) 
# alterando na tabela o nome das categorias
dimnames(t1)
#$`Estado Civil`
#[1] "solteiro" "casado"  

#$`Nivel de Instrucao`
#[1] "1oGrau"   "2oGrau"   "Superior"

t1f <- ftable(milsa[c(2, 3)], dnn = c("Estado Civil", "Nivel de Instrucao"))
dimnames(t1f) # a alteração de nome da categoria não funciona para tabela tipo 'ftable'
#NULL


## Tabelas para 3 variaveis e uso do with
# 1º:linha, 2º:coluna, 3º cat. para as tabelas 
t2 <- with(milsa, table(civil, instrucao, regiao)) 
t2
#, , regiao = capital

#instrucao
#civil      1oGrau 2oGrau Superior
#solteiro      2      1        1
#casado        2      4        1

#, , regiao = interior

#instrucao
#civil      1oGrau 2oGrau Superior
#solteiro      2      1        1
#casado        1      6        1

#, , regiao = outro

#instrucao
#civil      1oGrau 2oGrau Superior
#solteiro      3      4        1
#casado        2      2        1

t2f <- with(milsa, ftable(civil, instrucao, regiao)) 
t2f # tabela 'plana':
#                   regiao capital interior outro
#civil    instrucao                              
#solteiro 1oGrau                2        2     3
#         2oGrau                1        1     4
#         Superior              1        1     1
#casado   1oGrau                2        1     2
#         2oGrau                4        6     2
#         Superior              1        1     1

# Matriz ou array?
sapply(list(t2, t2f), is.matrix)
#[1] FALSE  TRUE
sapply(list(t2, t2f), is.array)
#[1] TRUE TRUE
sapply(list(t2, t2f), dim) #[[1]] 2 linhas e 3 colunas em 3 tabelas [[2]]:6 linhas e 3 colunas
#[[1]]
#[1] 2 3 3

#[[2]]
#[1] 6 3

# Eh possivel mudar a visualizacao da tabela tipo tftable com o col.vars
with(milsa, 
     ftable(civil, instrucao, regiao,
            dnn = c("Estado Civil:","Nivel de Instrucao", "Procedencia:"), 
            col.vars = c(1,3))) # variáveis da coluna: estado civil e procedencia
#                       Estado Civil: solteiro                 casado               
#Procedencia:                         capital interior outro capital interior outro
#Nivel de Instrucao                                                             
#1oGrau                                  2        2     3       2        1     2
#2oGrau                                  1        1     4       4        6     2
#Superior                                1        1     1       1        1     1

## Frequencias relativas
prop.table(t1)
prop.table(t1f)
round(prop.table(t1f), 2) # arredondando as casas decimais

prop.table(t1, margin = 1)
prop.table(t1f, margin = 1)

# Distribuicao marginal
margin.table(t1, mar = 1)
margin.table(t1, mar = 2)
addmargins(t1,mar=1)

## com o ftable nao funciona a funcao de calcular margens
margin.table(t1f, mar = 1)

# Graficao de barras para duas variaveis
barplot(t1, beside = T, legend = T) ## Com t1f fica sem nomes dos eixo!!!
barplot(t1, beside = F, legend = T) ## Outra variacao


##========================================================================
## Analise Descritiva e Exploratoria de Dados - variaveis quantitativas
##========================================================================

data(iris)   # entre parenteses informamos o nome do conjunto de dados 
iris          # exibe o conjunto de dados 
head(iris)
str(iris) ## Da detalhes sobre o banco de dados
attach(iris) 

#------------------------------------------
## Medidas resumo
# Medidas de posicao - mean, median, min, max, quantile

summary(Sepal.Length) # Para uma variavel apenas
summary(iris) # para todas as variaveis

# Podemos extratificar pela variavel categorica - 3 alternativas
summary(Sepal.Length[Species=="setosa"]) 
summary(Sepal.Length[Species=="versicolor"])  
summary(Sepal.Length[Species=="virginica"]) 

by(iris[,-5],Species,summary) # exclui a variável categórica 
tapply(Sepal.Length,Species,summary) # summary de Sepal.Lenght por Species. cria lista

#------------------------------------------
# Medidas de variabilidade - 
var(Sepal.Length)  # variancia
#[1] 0.6856935
sd(Sepal.Length)   # desvio padrao do vetor
#[1] 0.8280661
var(iris[,1:4]) ## matrix de covariancias
#             Sepal.Length Sepal.Width Petal.Length Petal.Width
#Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
#Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
#Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
#Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063

sd(iris[,1:4]) ## dá erro: Nao aceita data.frame

cv<- sd(Sepal.Length)/mean(Sepal.Length) # coeficiente de variacao

tapply(Sepal.Length,Species,sd) # desvio padrão  de 'Sepal.Lenght' por categoria 'Species'

#------------------------------------------
# Quantis
quantile(Sepal.Length) # quantis na forma padrão (0%, 25%, 50%, 75%, 100%)
quantile(Sepal.Length,probs=c(0.10,0.25,0.50,0.75,0.90)) 
sapply(iris[,1:4],quantile,probs=c(0.10,0.25,0.50,0.75,0.90)) # quantis das variáveis numéricas de 1 a 4


#------------------------------------------
## Graficos

# Grafico
plot(Sepal.Length,Petal.Length)
plot(Petal.Length~Sepal.Length)
abline(lm(Petal.Length~Sepal.Length)) ## Se uma regressao linear for adequada
abline(h=4, lwd = 3, lty = 3, col = 2)


plot(Sepal.Length,Petal.Length, 
     xlab="Comprimento da sepala", 
     ylab="Comprimento da Petala")

plot(Sepal.Length, Petal.Length, 
     cex=1, col="red") ## podemos, por exemplo, mudar o tamanho dos pontos(cex) ou a cor

cor(Sepal.Length,Petal.Length) ## coeficiente de correlacao de pearson

# Separando por Especie
x11(36,36)
plot(Sepal.Length[Species == "setosa"],Petal.Length[Species == "setosa"],
     cex = 0.8,pch = 8,
     xlim = range(Sepal.Length),ylim=range(Petal.Length),
     xlab = "Comprimento da sepala",ylab="Comprimento da Petala",cex.lab=1.2)
points(Sepal.Length[Species == "versicolor"],Petal.Length[Species == "versicolor"],
       cex=0.8,pch=2,col="blue")
points(Sepal.Length[Species == "virginica"],Petal.Length[Species == "virginica"],
       cex=0.8,pch=4,col="red")

# Fazendo uma lengenda
legend(locator(1),c("setosa","versicolor","virginica"),
       pch=c(8,2,4),col=c("black","blue","red"),cex=0.8, bty="n")

# Se quisermos algum texto dentro do grafico
text(Sepal.Length,Petal.Length, labels=round(Petal.Width, 2), pos=1, offset=0.5,cex=0.5)

text(5,6,"texto")


## O que acontece se plotamos um fator versus uma variavel continua?
plot(Species, Petal.Width) # é um boxplot


## Mais sobre a funcao plot
x = seq(1,10,by=1) 
x2 = x^2
x11()
par(mfrow=c(2,4))
plot(x, x2)
plot(x, x2, type= "l")
plot(x, x2, type= "b")
plot(x, x2, type= "h")
plot(x, x2, type= "c")
plot(x, x2, type= "s")
plot(x, x2, type= "S")
plot(x, x2, type= "o")

# Histograma
hist(Sepal.Length) 
hist(Sepal.Length, 
     main="Histograma para o comprimento da sepala de flores de iris",
     xlab="comprimento da sepala", 
     ylab="frequencia")

hist(Sepal.Length, 
     freq=F, 
     main="Histograma para o comprimento da sepala de flores de iris", 
     xlab="comprimento da sepala", 
     ylab="densidade de frequencia") 

# Diagrama de ramo e folhas
stem(Sepal.Length)

# Diagrama de pontos 
stripchart(Sepal.Length,method="stack", xlab= "comprimento da sepala")
stripchart(Sepal.Length~Species,method="stack",xlab="comprimento da sepala")

# Boxplot
boxplot(Sepal.Length,
        ylab="comprimento da sepala(cm)", 
        main="Boxplot para comprimento da sepala de flores de iris")

boxplot(Sepal.Length~Species, 
        ylab = "comprimento  da sepala",
        main = "Boxplot do comprimento da  sepala segundo especie") 

#------------------------------------------
## Para histogramas separados por especie
# obs: para quebrar a linha no texto do título basta quebrar na linha de comando
x11()
par(mfrow=c(3,1))   # mfrow=c(3,1) especifica que a janela e dividida 
hist(Sepal.Length[Species=="setosa"],
     freq=F, 
     main="Histograma de comprimento da sepala 
     para flores de iris setosa", 
     xlab="comprimento da sepala(cm)", 
     ylab="densidade de frequencia") 

hist(Sepal.Length[Species=="versicolor"],
     freq=F,
     main="Histograma de comprimento da sepala 
     para flores de iris versicolor", 
     xlab="comprimento da sepala(cm)",
     ylab="densidade de frequencia") 

hist(Sepal.Length[Species=="virginica"],
     freq=F,
     main="Histograma de comprimento da sepala 
     para flores de iris virginica", 
     xlab="comprimento da sepala(cm)",
     ylab="densidade de frequencia") 

#------------------------------------------
# Para facilitar a comparaçao podemos especificar as mesmas classes para os 3 histogramas como o 
# argumento breaks (limites de classe). 
## breaks -> O número (aproximado) de retângulos.
## breaks=seq(4,8,0.5) -> eixo x varia de 4 até 8 em passos de 0.5
## com freq=F o histograma apresenta a densidade de probabilidade

x11()
par(mfrow=c(3,1), mar= c(5,5,5,4)) ## alterando as margens da janela grafica 
hist(Sepal.Length[Species=="setosa"],
     freq=F,
     breaks=seq(4,8,0.5),
     main = "Histograma de comprimento da sepala 
     para flores de iris setosa", 
     xlab="comprimento da sepala(cm)",
     ylab="Densidade") 

hist(Sepal.Length[Species=="versicolor"],
     freq=F,
     breaks=seq(4,8,0.5), 
     main="Histograma de comprimento da sepala 
     para flores de iris versicolor", 
     xlab="comprimento da sepala(cm)", 
     ylab="Densidade", 
     col=2, angle = 70, density = 40) 

hist(Sepal.Length[Species=="virginica"],
     freq=F, 
     breaks=seq(4,8,0.5), 
     main="Histograma de comprimento da sepala 
     para flores de iris virginica",
     xlab="comprimento da sepala(cm)", 
     ylab = "Densidade",
     border = 4, col = "gray", density = 30, angle=180, cex.lab=2)

## Repare que diversos argumentos podem ser alterados para darem outra cara aos graficos

# para retornar a um quadro por tela
par(mfrow = c(1,1))
##=-===================================
## Mais sobre plot, lines, etc

n <- 50
x <- seq(-1,1,length=n)
op <- par(mfrow=c(2,2), lwd=2, cex.axis=1.5, cex.lab=1.5)
plot(x, type="l")
plot(x, x^2, type="l")
plot(x, 1/x, type="l")
plot(x, x^3, type="l")
# um outro exemplo
win.graph()
op <- par(mfcol=c(2,3), lwd=2, cex.axis=1.5, cex.lab=1.5, mar=c(5,5,5,5))
plot(x, type="l", main="(a)")
plot(x, x^2, type="l", main="(b)",ylab=expression(x^2))
plot(x, 1/x, type="l", main="(c)")
plot(x, x^3, type="l", main="(d)")
plot(x,1-x^2, type="l", main="(e)")
plot(x, 1-1/x, type="l", main="(f)")


## Ilustrando o par(new=TRUE)
n <- 20
x <- seq(-2,2,length=n)
y1 <- x
y2 <- x^2
y3 <- x^3

plot(x,y1, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2)
par(new=TRUE)

plot(x,y2, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2, 
     lty=2)
par(new=TRUE)

plot(x,y3, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2, 
     lty=3)

# acertando os eixos:
win.graph()
plot(x,y1, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2, 
     xlim=range(x),
     ylim=range(y1,y2,y3))
par(new=TRUE)

plot(x,y2, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2, 
     lty=2,
     ylim=range(y1,y2,y3))
par(new=TRUE)

plot(x,y3, 
     xlab="x", 
     ylab="f(x)", 
     type="l", 
     lwd=2, 
     lty=3,
     ylim=range(y1,y2,y3))

## line e abline
n <- 50
x <- seq(-2*pi,2*pi, length=n)
y <- sin(x)
# aplicando a funcoes lines
plot(x,y, xlab="x", ylab="seno(x)", main="Exemplo: lines()")
lines(x,y)
lines(x, rep(0,n), lty=2)
# aplicando simultaneamente as funcoes lines e abline:

win.graph() 
plot(x,y, 
     xlab="x", 
     ylab="seno(x)", 
     main="Exemplo: lines() e abline()")
lines(x,y)
x.axis <- seq(-6,6,by=2)
y.axis <- seq(-1,1,by=0.25)
abline(v=x.axis, h=y.axis, lty=2, col="gray")


# legendas com expressoes matematicas:
n <- 20
x <- seq(-1,1,length=n)
y1 <- x
y2 <- x^2
y3 <- x^3
op <- par(lwd=2, cex.axis=1.5, cex.lab=1.5)

plot(x,y1, 
     xlim=range(x), 
     ylim=range(y1,y2,y3), 
     xlab="x", 
     ylab="f(x)", 
     type="l")

par(new=TRUE)

plot(x,y2, 
     xlim=range(x), 
     ylim=range(y1,y2,y3), 
     xlab="x", 
     ylab="f(x)", 
     type="l",
     lty=2)

par(new=TRUE)

plot(x,y3, 
     xlim=range(x), 
     ylim=range(y1,y2,y3), 
     xlab="x", 
     ylab="f(x)", 
     type="l",
     lty=3)

legend("bottomright", 
       lty=1:3, 
       c(expression(f(x) == x), 
         expression(f(x) == x^2),
         expression(f(x) == x^3)), 
       lwd = 1, 
       bty = "n", 
       cex = 1.5)

## Ilustrando o uso das funções segments e arrows:
x = sample(1:10, 6) # 6 números aleatórios variando de 1 a 10
x
#[1]  8  2  5  6  1 10
y = sample(1:10, 6) # 6 números aleatórios variando de 1 a 10
y
#[1]  3 10  4  8  2  1
par(lwd=2)
plot(1:10, 1:10, axes=FALSE)
axis(1,1:10)
axis(2,1:10)
axis(3,1:10)
axis(4,1:10)
abline(h=y, v=x, col="gray", lty=3)
segments(x[1], y[1], x[2], y[2], col = 3) #verde:reta da posição:x[1]y[1](8,3) até posição x[2]y[2] (2,10)
segments(x[2], y[2], x[3], y[3], col = 2) #vermelho: reta da posição:x[2]y[2] até posição x[3]y[3](5,4)
arrows(x[4], y[4], x[5], y[5], col = 6) #magenta: seta saindo da posição:x[4]y[4](6,8) até posição x[5]y[5](1,2)  
arrows(x[5], y[5], x[6], y[6], col = 4) #azul:seta saindo da posição:x[5]y[5](1,2) até posição x[6]y[6](10,1)


###==============================================================================
## Pacote Tables
# http://www.dadosaleatorios.com.br/2014/01/ferramentas-para-criar-tabelas-latex.html
require(tables)

## tabela
tabular(Species ~ (n=1) + 
          Format(digits=2)* (Sepal.Length + Sepal.Width)*(mean + sd),
        data=iris)

## tabela com codigo latex
latex(tabular(Species ~ (n=1) + Format(digits=2)* (Sepal.Length + Sepal.Width)*(mean + sd),
              data=iris), options=list(doFooter=FALSE, doEnd=FALSE))

latex(tabular(1 ~ (n=1) + Format(digits=2)*
                (Sepal.Length + Sepal.Width)*(mean + sd), data=iris),
      options=list(doBegin=FALSE, doHeader=FALSE))

## outro exemplo
formula = (as.factor(gear) + 1) ~ (n = 1) + (hp + wt) * (mean + sd)
tabular(formula, data = mtcars)