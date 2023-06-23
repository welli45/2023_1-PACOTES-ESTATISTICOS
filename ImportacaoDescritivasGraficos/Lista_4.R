#===---===---===---===---===---===---===---===---===---===---===---===---===---
## Resolução da lista 4

##  Aluno(a) 1: Wellington Santos Souza
##  Matricula 1: 2019012213


#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 1 ----


# Salvando bases nos formatos solicitados na questão ----------------------

data(Orange)
Orange

data(InsectSprays)
InsectSprays

data(ChickWeight)
ChickWeight

write.table(Orange, 'Orange.txt')

write.table(InsectSprays, 'InsectSprays.csv', sep = ';')

if(!require(writexl)){install.packages("writexl")};library(writexl)

write_xlsx(ChickWeight, 'ChickWeight.xlsx', col_names = T)

# Carregando bases --------------------------------------------------------

Dados1 <- read.table('Orange.txt')
Dados2 <- read.csv('InsectSprays.csv', sep=';')

if(!require(readxl)){install.packages("readxl")};library(readxl)
Dados3 <- read_excel('ChickWeight.xlsx')

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 2 ----

if(!require(aplore3)){install.packages("aplore3")};library(aplore3)

attach(icu)

# Criando tabela de frequência absoluta -----------------------------------

# uma variável
t1 <- table(sta)
t1
# duas variáveis
t2 <- table(icu[,c(2,5)])
t2

# Criando tabela de frequência relativa -----------------------------------

# uma variável
prop.table(t1)

# duas variáveis
prop.table(t2)
# Criando gráficos  com as duas variáveis selecionadas --------------------

# uma variável
pie(t1, main = 'Vital Status at hospital discharge',col = c("blue", "red"))

# duas variáveis

barplot(t2, beside = T, legend=T,col = c(3, 9))

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 3 ----
if(!require(summarytools)){install.packages("summarytools")};library(summarytools)

# refazendo tabelas do item anterior

freq(icu$sta)

ctable(icu$sta,icu$race)

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 4 ----

# obtendo o subconjunto com informações solicitadas na questão

sub_icu <- subset(icu, gender=='Female' & sta == 'Lived')

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 5 ----

# Criar a matriz de gráficos usando a função layout
layout(matrix(1:6, nrow=2, ncol=3))

# Criar os gráficos separadamente
g1 <- plot(cars)
g2 <- hist(rnorm(100))
g3 <- boxplot(iris$Sepal.Length, iris$Species)
g4 <- plot(airquality$Wind, airquality$Ozone)
g5 <- barplot(table(mtcars$gear))
#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 6 ----
layout(1:1)

# Calcula a função de distribuição cumulativa empírica
fda <- ecdf(mtcars$mpg)

# Plotar o gráfico de frequência acumulada
plot(fda, verticals = TRUE, do.points = FALSE,
     xlab = "Miles per Gallon", ylab = "Cumulative Frequency",
     main = "Cumulative Frequency Plot for MPG in mtcars")

#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 7 ----


# Questão a ---------------------------------------------------------------

if(!require(MASS)){install.packages("MASS")};library(MASS)
# Carrega o conjunto de dados
data(UScrime)

df <- data.frame(Po1 = UScrime$Po1, Po2 = UScrime$Po2)
mean1959 <- mean(df$Po1)
mean1960 <- mean(df$Po2)


if (mean1959 > mean1960) {
  cat("O ano com a maior média de despesas policiais foi 1959: $", round(mean1959, 2), "\n")
} else if (mean1960 > mean1959) {
  cat("O ano com a maior média de despesas policiais foi 1960: $", round(mean1960, 2), "\n")
} else {
  cat("As médias de despesas policiais em 1959 e 1960 são iguais: $", round(mean1959, 2), "\n")
}


# Questão b ---------------------------------------------------------------

# Selecionar subamostra de homens com 14-24 anos de idade e valores não faltantes para U1
uscrime_male_14_24 <- UScrime[UScrime$M >= 14 & UScrime$M <= 24 & !is.na(UScrime$U1),]

# Encontrar a taxa de desemprego máxima e mínima
max_unemployment_rate <- max(uscrime_male_14_24$U1, na.rm = TRUE)
min_unemployment_rate <- min(uscrime_male_14_24$U1, na.rm = TRUE)

# Imprimir a taxa de desemprego máxima e mínima
cat("A taxa de desemprego máxima é", max_unemployment_rate, "e a taxa de desemprego mínima é", min_unemployment_rate, "\n")

max_unemployment_state <- uscrime_male_14_24[uscrime_male_14_24$U1 == max_unemployment_rate, "So"]
mean_police_max_unemployment_state <- mean(UScrime[UScrime$So == max_unemployment_state, "Po1"], na.rm = TRUE)
cat("A média de despesas policiais em 1960 para o estado que teve maior taxa de desemprego entre homens com 14-24 anos é", mean_police_max_unemployment_state, "\n")


# questão d ---------------------------------------------------------------

cor(UScrime$Po2, UScrime$Pop, use = "complete.obs")

uscrime_male_35_39 <- UScrime[!is.na(UScrime$U2), ]
plot(uscrime_male_35_39$Po1, uscrime_male_35_39$U2, xlab = "Gastos policiais em 1960", ylab = "Taxa de desemprego entre homens com 35-39 anos")
#===---===---===---===---===---===---===---===---===---===---===---===---===---

# questão e ---------------------------------------------------------------

uscrime_male_35_39 <- UScrime[!is.na(UScrime$U2), ]
plot(uscrime_male_35_39$Po1, uscrime_male_35_39$U2, xlab = "Gastos policiais em 1960", ylab = "Taxa de desemprego entre homens com 35-39 anos")

# Questão 8 ----

scoresPad <- function(variable){
  mean_val <- mean(variable)
  std_dev <- sd(variable)
  return((variable - mean_val) / std_dev)
}


#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 9 ----
descr(icu)

stby(icu$age, icu$death, stats = c("mean", "sd", "median", "IQR", "n"), na.summary = TRUE)


#===---===---===---===---===---===---===---===---===---===---===---===---===---

# Questão 10 ----

if(!require(jmv)){install.packages("jmv")};library(jmv)

# Tabela de estatísticas descritivas para a variável age
describe(icu$age)

stby(icu, icu$death, statistics = c("mean", "sd", "median", "IQR", "n"), na.summary = FALSE)



#===---===---===---===---===---===---===---===---===---===---===---===---===---

