# carregando pacote

library(tidyverse)
# perguntas que iremos responder

# Carros com motores grandes usam mais combustível do que carros com motores 
# pequenos?
  
# Qual é a relação entre o tamanho do motor e a eficiência de combustível? 
# É positivo? Negativo? Linear? Não linear?

# banco de dados
?mpg

# criando o gráfico
ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy))

# mapeamentos estéticos
ggplot(data= mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy, color = class))

# tamanho dos pontos, com erro, pois a variável class não é ordenada
ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy, alpha = class))

# mudando o shape, com erro, pois o ggplot só plota 6 variáveis de uma vez. 
ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy, shape = class))

# mudando as cores dos pontos
ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy), color = "red")

ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy), color = "blue")

# facetas

# facetando o gráfico com 2 variáveis
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")+
  facet_wrap(~ class, nrow = 2)

# facetando o gráfico na combinação de duas variáveis
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")+
  facet_grid(drv ~ cyl)

# em nível de colunas
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")+
  facet_grid(. ~ cyl)

# objetos geométricos
ggplot(data = mpg)+
  geom_smooth(
    mapping = aes(x = displ, y = hwy))
# mudando o tipo de linha e mudando a cor da linha
ggplot(data = mpg)+
  geom_smooth(
    mapping = aes(x = displ, y = hwy, linetype = drv), color = "red")

# adicionando os pontos 
ggplot(data = mpg)+
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), color = "blue")+
  geom_point(mapping = aes(x = displ, y = hwy))

# mais geoms: https://exts.ggplot2.tidyverse.org/gallery/

# folha de dicas:  http://rstudio.com/resources/cheatsheets

# group para uma variável categórica para desenhar vários objetos.
ggplot(data = mpg)+
  geom_smooth(mapping = aes(x = displ, y = hwy))

# agrupando por drv. É importante lembrar que a cor não é adicionada automáticamente
ggplot(data = mpg)+
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

# adicionando a cor.
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = F
  )


# vários geom no mesmo gráfico
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# evitando duplicações no código
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()

# adicionando mapeamentos nas camadas
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = class))+
  geom_smooth()

# especificando diferentes data
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Transformações estatísticas

# O gráfico a seguir exibe o número total de diamantes no conjunto de dados diamonds, 
# agrupados por cut.
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut))

# transformando o padrão count para prop
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1))

# outras mudanças
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(mpg, aes(trans, cty)) +
  geom_point() +
  stat_summary(geom = "point", fun = "mean", colour = "red", size = 4)

# estatísticas que podemos usar
?stat_bin

# Sistemas de coordenadas

# boxplots horizontais
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

# estéticas gráfico de barras
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# Labels

# título
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")

# título, subtítulo e legenda
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )

# títulos dos eixos
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )
# usando equações matemáticas
df <- tibble(
  x = runif(10),
  y = runif(10)
)
ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(sum(x[i] ^ 2, i == 1, n)),
    y = quote(alpha + beta + frac(delta, theta))
  )

# Escalas

# alterando as escalas padrões
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()

# alterando os valores das escalas
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))

# tirando os valores das escalas x e y
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

# Layout da legenda
# alterando
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))

# esquerda
base + theme(legend.position = "left")

# no topo
base + theme(legend.position = "top")

# abaixo
base + theme(legend.position = "bottom")

# direita
base + theme(legend.position = "right") 

# Substituindo uma escala
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d()
# transformação log
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()


# Zoom
ggplot(mpg, mapping = aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth() +
  coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))
# limites em escalas individuais
suv <- mpg %>% filter(class == "suv")
compact <- mpg %>% filter(class == "compact")

ggplot(suv, aes(displ, hwy, colour = drv)) +
  geom_point()
  
# temas; https://github.com/jrnold/ggthemes 
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

# outros temas
library(ggthemes)
library(gridExtra)

grafico <- ggplot(mpg, aes(displ, hwy, col=factor(cyl))) + geom_point() + 
  geom_smooth(method = "lm", se = F) + ggtitle("Cilindradas, cilindros e Milhas por Galão") + 
  ylab("Milhas por galão") + xlab("Cilindradas")

# Grafico original
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

# Agrupando gráficos em uma única figura

## Para colocar varios graficos juntos
g1 <- grafico + theme_fivethirtyeight() 
g2 <- grafico + theme_hc() + scale_color_hc()
g3 <- grafico + theme_tufte() 
g4 <- grafico + theme_stata() + scale_color_stata()
grid.arrange(g1, g2, g3, g4)

# Salvando seus gráficos
ggplot(mpg, aes(displ, hwy)) + geom_point()
ggsave("my-plot.pdf")


# Outro ótimo recurso é a galeria de extensões ggplot2 https://exts.ggplot2.tidyverse.org/gallery/melhor lugar para aprender mais é o livro ggplot2: ggplot2: Elegant graphics for data analysis.
