library(tidyverse)
library(brazilmaps)
library(basedosdados)

# Defina o seu projeto no Google Cloud
set_billing_id("basededados-391412")

# Para carregar o dado direto no R
query <- bdplyr("br_inep_ideb.municipio")
df <- bd_collect(query)












