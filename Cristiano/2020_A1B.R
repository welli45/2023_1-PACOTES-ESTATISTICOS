#############################################################
#####  Script da Aula - Um pouco sobre bancos de dados  #####
#############################################################
# Remover os bancos de dados da área de trabalho
rm(list = ls())

# Vendo qual eh o diretorio de trabalho
getwd()

# Mude o diretorio para a pasta mais adequada
setwd("~/Documents/EST_R/PACOTES ESTATÍSTICOS")

##===========================================================

### Bancos de dados existentes
data() #Os bancos de dados nativos do R
data(women)
women 
head(women) # primeiras 6 linhas do BD
help(women) # explica o banco de dados (women) nativo do R
mode(women) # diz o modo que está salvo o arquivo
#============================================================

## Exportacao de dados
women
write.table(women, file = "women.txt",row.names = FALSE)
write.table(women, file = "women2.txt",row.names = FALSE,col.names = FALSE)
write.table(women, file = "women.csv",row.names = FALSE)
write.csv(women, file = "women.csv",row.names = FALSE)

#install.packages("foreign")
library(foreign)
write.foreign(women, "mydata.txt", "mydata.sas",   package="SAS")
?write.foreign

#install.packages("xlsx") 
#require(xlsx)
write.xlsx(women, "women.xlsx")

require(readxl)
write_excel_csv("women.xls") #deu erro (12/03) ver depois


##===========================================================
## Importacao de dados

dados1 = read.table("women.txt", header = TRUE, sep = " ")

# Se o arquivo txt tiver apenas variaveis numericas e nao tiver nome das covariaveis eh possivel usar o scan 
dados2 = scan("women2.txt", sep = " ") # Inicialmente fica em formato de vetor
?scan #
dados2 = matrix(dados2, ncol=2, byrow = TRUE)
dados3 = read.table("women.csv", header = TRUE, sep = " ")
dados4 = read.csv("women.csv", fill = TRUE, sep = " ")

# arquivo resultante eh uma lista, mas voce pode transformar para matrix ou data.frame facilmente
mode(dados1)
as.matrix(dados4)
data.frame(dados1)

# Mais um exemplo
dados5 <- read.table("dados_Exemplo3.csv", head=T, sep=":", dec=",") 

# A funçao read.table permite ler diretamente da internet
read.table("http://www.leg.ufpr.br/~paulojus/dados/gam01.txt")

# Eh possivel ler da area de transferencia - Basta dar control+c em um banco de dados e usar:
dados6 = read.table("clipboard", header=FALSE, dec=",")


## Para ler planilhas do excel podemos usar 
install.packages("readxl") # CRAN version
library(readxl)
dados = read_excel("women.xlsx", sheet = 1)
head(dados)

