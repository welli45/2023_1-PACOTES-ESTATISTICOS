
# Estudos -----------------------------------------------------------------


# Primeira parte ----------------------------------------------------------

# Aqui estamos mostrando o perígo do copiar e colar na hora de escrever um 
# código em R. 

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

# um erro aqui!
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))

df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

# O ideal é usar funções para isso. Entretanto, primeiramente precisamos avaliar
# as entradas no código. 

# Quais são as entradas nesse código?
# essse código possui apenas uma entrada df$a, com isso, podemos substituir a
# entrada por um único vetor. 

x <- df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

x

# existe alguma duplicação? Se sim, podemos fazer isso:

rng <- range(x, na.rm=T)
(x-rng[1])/(rng[2]-rng[1])


# exemplo com uam função

rescale01 <- function(x){
  rng = range(x, na.rm = T) 
  (x-rng[1])/(rng[2]-rng[1])
}

rescale01(df$a)

x <- 2:8

rescale01(x)









