#############################################################
#######  Script da Aula 8 - Pacotes estatisticos  ###########
#############################################################
getwd()

# Pacotes utilizados
#install.packages("ggplot2")


##==========================================================================================

## ggplot2

# http://www.cookbook-r.com/Graphs/
# http://curso-r.github.io/posts/aula05.html
# http://analisereal.com/2015/09/19/introducao-ao-ggplot2/
# http://rcoster.blogspot.com.br/2014/04/fazendo-graficos-bonitos-no-r.html
# https://plot.ly/ggplot2/geom_bar/
# https://www.rstudio.com/wp-content/uploads/2016/03/ggplot2-cheatsheet-portuguese.pdf

library(ggplot2)
head(mtcars)

# Grafico de x versus y
ggplot(data = mtcars, aes(x = disp, y = mpg)) + 
  geom_point()

# Equivalentemente
ggplot(data = mtcars) + 
  geom_point(aes(x = disp, y = mpg))


# Separando por uma terceira variavel que eh um fator - colour
ggplot(data = mtcars, aes(x = disp, y = mpg, colour = as.factor(am))) + 
  geom_point()

# Separando com o shape
ggplot(data = mtcars, aes(x = disp, y = mpg, shape = as.factor(am))) + 
  geom_point(size=3 ,colour = "red")

# Separando por uma variavel continua
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl)) + 
  geom_point()

# o tamanho tambÃ©m pode representar uma variavel
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl, size = wt)) +
  geom_point()

# Boxplots
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot()

# Grafico de barras
ggplot(mtcars, aes(x = as.factor(cyl))) + 
  geom_bar()

dplot <- ggplot(diamonds, aes(color, fill = cut)) +
  xlab(NULL)+ ylab(NULL)+ theme(legend.position = "none")

dplot + geom_bar()
dplot + geom_bar(position = "fill")
dplot + geom_bar(position = "dodge")

# cores
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, colour = as.factor(cyl))) + 
  geom_boxplot()


ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, fill = as.factor(cyl))) + geom_boxplot()

## Todos da mesma cor
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot(color = "red", fill = "pink")

# Density
ggplot(data=mtcars, aes(x=mpg)) + geom_density(fill =3)

# aes(color) compartilhado
ggplot(mtcars, aes(disp, mpg, color=as.factor(am))) + geom_point() + 
  geom_smooth(method="lm") 

# aes(color) apenas nos pontos
ggplot(mtcars, aes(disp, mpg)) + geom_point(aes(color=as.factor(am))) + 
  geom_smooth(method="lm") 


## Eixos

# nomes 
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram(color = "blue",fill="white") +
  xlab("Milhas por galÃ£o") +
  ylab("FrequÃªncia")
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.

# limites
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram(fill="blue",color="yellow") +
  xlab("Milhas por galÃ£o") +
  ylab("FrequÃªncia") +
  xlim(c(0, 40)) +
  ylim(c(0,8))


# legenda 
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +  labs(fill = "cyl")

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl") +
  theme(legend.position="top")

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  guides(fill=FALSE)

## Facets
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) + 
  geom_point() + 
  facet_grid(am~.,scales="free") ## free_y ou free_x deixa apenas um dos eixos com escalas diferentes

ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) +
  geom_point() + 
  facet_grid(.~am)

## Outra forma
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) +
  geom_point() + facet_wrap(~ am,ncol=2) ## permite especificar o nÃºmero de colunas




## Um exemplo cheio de configuracoes
x11(width = 12, height = 18)
ggplot( mtcars, aes( x = as.factor(am), y = disp ) ) + theme_bw() +
  geom_boxplot( alpha = 0.2, size = 0.5, outlier.colour = c("grey40") , outlier.size=2,width=0.8) +
  scale_fill_manual(values=gray.colors(3)) + 
  theme(axis.text=element_text(size=8), axis.title=element_text(size=9), 
        strip.text = element_text(size=9),plot.margin = unit(c(0.05, 0.2, 0.05, 0.05), "cm"))+
  labs(title="", x="am", y="Disp")


## Estatisticas no grafico
ggplot(mpg, aes(trans, cty)) +
  geom_point() +
  stat_summary(geom = "point", fun.y = "mean", colour = "red", size = 4)


df <- data.frame(dose=c("D0.5", "D1", "D2"),
                 len=c(4.2, 10, 29.5))
head(df)

ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", color="blue", fill="white")

ggplot(data=df, aes(x=dose, y=len)) +
  geom_col( color="blue", fill="white")


df <- data.frame(dose=c("D0.5", "D1", "D2","D0.5", "D1", "D2"),
                 len=c(4.2, 10, 29.5,5,15,36))

head(df)

ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", color="blue", fill="white")

ggplot(data=df, aes(x=dose, y=len)) +
  stat_summary(geom = "bar", fun.y = "mean", colour = "red", size = 2, fill=5)

ggplot(data=df, aes(x=dose, y=len)) +
  stat_summary(geom = "point", fun.y = "mean", colour = "red", size = 2, fill=5)

ggplot(data=df, aes(x=dose, y=len)) +
  stat_summary(geom = "bar", fun.y = "sd", colour = "red", size = 2, fill=5)


ggplot(data=df, aes(x=dose)) +
  geom_bar(stat="count", color="blue", fill=5)

## temas
#install.packages("ggthemes")
#install.packages("gridExtra")
library(ggthemes)
library(gridExtra)

grafico <- ggplot(mpg, aes(displ, hwy, col=factor(cyl))) + geom_point() + 
  geom_smooth(method = "lm", se = F) + ggtitle("Cilindradas, cilindros e Milhas por GalÃ£o") + 
  ylab("Milhas por galÃ£o") + xlab("Cilindradas")

# GrÃ¡fico original
grafico

# Tema "The Economist" com respectiva escala de cores
grafico + theme_economist() + scale_color_economist()

# Tema "The Wall Street Journal" com respectiva escala de cores
grafico + theme_wsj() + scale_color_wsj()

# Tema "Excel" com respectiva escala de cores
grafico + theme_excel() + scale_color_excel()


# Tema "fivethirtyeight"
grafico + theme_fivethirtyeight() 


# Tema "highcharts" com respectiva escala de cores
grafico + theme_hc()  + scale_color_hc()


# Tema "Tufte" 
grafico + theme_tufte() 


# Tema "Stata" com respectiva escala de cores
grafico + theme_stata() + scale_color_stata()


## Para colocar varios graficos juntos
g1 <- grafico + theme_fivethirtyeight() 
g2 <- grafico + theme_hc() + scale_color_hc()
g3 <- grafico + theme_tufte() 
g4 <- grafico + theme_stata() + scale_color_stata()
grid.arrange(g1, g2, g3, g4)

