library(shiny)
library(shinythemes)
library(ggplot2)
library(ggthemes)
library(tidyverse)
library(basedosdados)
library(fivethirtyeight)
# Defina o seu projeto no Google Cloud
set_billing_id("basededados-391412")

# Para carregar o dado direto no R
query <- bdplyr("br_inep_ideb.brasil")
ideb_data <- bd_collect(query)


ui <- fluidPage(
  theme = shinytheme("cerulean"),
  titlePanel("Índice de Desenvolvimento da Educação Básica (Ideb)"),
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        condition = "input.tabs == 'Rede de Ensino'",
        selectInput("rede", "Rede", choices = unique(ideb_data$rede)),
        sliderInput("rede_ano", "Ano", min(ideb_data$ano), max(ideb_data$ano), value = c(min(ideb_data$ano), max(ideb_data$ano)), step = 1)
      ),
      conditionalPanel(
        condition = "input.tabs == 'Ensino'",
        selectInput("ensino", "Ensino", choices = unique(ideb_data$ensino)),
        sliderInput("ensino_ano", "Ano", min(ideb_data$ano), max(ideb_data$ano), value = c(min(ideb_data$ano), max(ideb_data$ano)), step = 1)
      ),
      conditionalPanel(
        condition = "input.tabs == 'Anos Escolares'",
        selectInput("anos_escolares", "Anos Escolares", choices = unique(ideb_data$anos_escolares)),
        sliderInput("anos_escolares_ano", "Ano", min(ideb_data$ano), max(ideb_data$ano), value = c(min(ideb_data$ano), max(ideb_data$ano)), step = 1)
      ),
      uiOutput("cards")
    ),
    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Informações gerais",
                           h2("Índice de Desenvolvimento da Educação Básica (Ideb)"),
                           p("O Índice de Desenvolvimento da Educação Básica (Ideb) foi criado em 2007 e reúne, em um só indicador, os resultados de dois conceitos igualmente importantes para a qualidade da educação: o fluxo escolar e as médias de desempenho nas avaliações. Ele é calculado a partir dos dados sobre aprovação escolar, obtidos no Censo Escolar, e das médias de desempenho nas avaliações do Inep, o Sistema de Avaliação da Educação Básica (Saeb) – para as unidades da federação e para o país, e a Prova Brasil – para os municípios."),
                           p("O Ideb agrega ao enfoque pedagógico dos resultados das avaliações em larga escala do Inep a possibilidade de resultados sintéticos, facilmente assimiláveis, e que permitem traçar metas de qualidade educacional para os sistemas. O índice varia de zero a 10 e a combinação entre fluxo e aprendizagem tem o mérito de equilibrar as duas dimensões: se um sistema de ensino retiver seus alunos para obter resultados de melhor qualidade no Saeb ou Prova Brasil, o fator fluxo será alterado, indicando a necessidade de melhoria do sistema. Se, ao contrário, o sistema apressar a aprovação do aluno sem qualidade, o resultado das avaliações indicará igualmente a necessidade de melhoria do sistema."),
                           p("O Ideb também é importante por ser condutor de política pública em prol da qualidade da educação. É a ferramenta para acompanhamento das metas de qualidade do Plano de Desenvolvimento da Educação (PDE) para a educação básica, que tem estabelecido, como meta, que em 2022 o Ideb do Brasil seja 6,0 – média que corresponde a um sistema educacional de qualidade comparável a dos países desenvolvidos."),
                           h4("Organização: Instituto Nacional de Estudos e Pesquisas Educacionais (Inep)"),
                           h4("Cobertura temporal: 2005 – 2021"),
                           p("Esse trabalho foi elaborado por Wellington Santos Souza, como parte da disciplina de Pacotes estatísticos ofertada pelo professor Cristiano de Carvalho no primeiro semestre de 2023.")
                  ),
                  tabPanel("Rede de Ensino",
                           plotOutput("rede_taxa_aprovacao"),
                           plotOutput("rede_ideb")
                  ),
                  tabPanel("Ensino",
                           plotOutput("ensino_taxa_aprovacao"),
                           plotOutput("ensino_ideb")
                  ),
                  tabPanel("Anos Escolares",
                           plotOutput("anos_escolares_taxa_aprovacao"),
                           plotOutput("anos_escolares_ideb")
                  )
      )
    )
  )
)

server <- function(input, output) {
  output$cards <- renderUI({
    if (input$tabs == "Rede de Ensino") {
      data <- ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],]
      tagList(
        wellPanel(
          h4(paste0("Nota Saeb Matemática: ", round(mean(data$nota_saeb_matematica), 2))),
          h4(paste0("Nota Saeb Língua Portuguesa: ", round(mean(data$nota_saeb_lingua_portuguesa), 2))),
          h4(paste0("Nota Saeb Média Padronizada: ", round(mean(data$nota_saeb_media_padronizada), 2)))
        )
      )
    } else if (input$tabs == "Ensino") {
      data <- ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],]
      tagList(
        wellPanel(
          h4(paste0("Nota Saeb Matemática: ", round(mean(data$nota_saeb_matematica), 2))),
          h4(paste0("Nota Saeb Língua Portuguesa: ", round(mean(data$nota_saeb_lingua_portuguesa), 2))),
          h4(paste0("Nota Saeb Média Padronizada: ", round(mean(data$nota_saeb_media_padronizada), 2)))
        )
      )
    } else if (input$tabs == "Anos Escolares") {
      data <- ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],]
      tagList(
        wellPanel(
          h4(paste0("Nota Saeb Matemática: ", round(mean(data$nota_saeb_matematica), 2))),
          h4(paste0("Nota Saeb Língua Portuguesa: ", round(mean(data$nota_saeb_lingua_portuguesa), 2))),
          h4(paste0("Nota Saeb Média Padronizada: ", round(mean(data$nota_saeb_media_padronizada), 2)))
        )
      )
    }
  })

  output$rede_taxa_aprovacao <- renderPlot({
    ggplot(ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],] %>% group_by(ano) %>% summarise(taxa_aprovacao = mean(taxa_aprovacao)), aes(x = ano, y = taxa_aprovacao)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(taxa_aprovacao, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Taxa de Aprovação por Ano", x = "Ano", y = "Taxa de Aprovação")
  })

  output$rede_ideb <- renderPlot({
    ggplot(ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],] %>% group_by(ano) %>% summarise(ideb = mean(ideb)), aes(x = ano, y = ideb)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(ideb, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Ideb por Ano", x = "Ano", y = "Ideb")
  })

  output$rede_nota_saeb_matematica <- renderText({
    paste("Nota Saeb Matemática:", round(mean(ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],]$nota_saeb_matematica), 2))
  })

  output$rede_nota_saeb_lingua_portuguesa <- renderText({
    paste("Nota Saeb Língua Portuguesa:", round(mean(ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],]$nota_saeb_lingua_portuguesa), 2))
  })

  output$rede_nota_saeb_media_padronizada <- renderText({
    paste("Nota Saeb Média Padronizada:", round(mean(ideb_data[ideb_data$rede == input$rede & ideb_data$ano >= input$rede_ano[1] & ideb_data$ano <= input$rede_ano[2],]$nota_saeb_media_padronizada), 2))
  })

  output$ensino_taxa_aprovacao <- renderPlot({
    ggplot(ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],] %>% group_by(ano) %>% summarise(taxa_aprovacao = mean(taxa_aprovacao)), aes(x = ano, y = taxa_aprovacao)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(taxa_aprovacao, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Taxa de Aprovação por Ano", x = "Ano", y = "Taxa de Aprovação")
  })

  output$ensino_ideb <- renderPlot({
    ggplot(ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],] %>% group_by(ano) %>% summarise(ideb = mean(ideb)), aes(x = ano, y = ideb)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(ideb, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Ideb por Ano", x = "Ano", y = "Ideb")
  })

  output$ensino_nota_saeb_matematica <- renderText({
    paste("Nota Saeb Matemática:", round(mean(ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],]$nota_saeb_matematica), 2))
  })

  output$ensino_nota_saeb_lingua_portuguesa <- renderText({
    paste("Nota Saeb Língua Portuguesa:", round(mean(ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],]$nota_saeb_lingua_portuguesa), 2))
  })

  output$ensino_nota_saeb_media_padronizada <- renderText({
    paste("Nota Saeb Média Padronizada:", round(mean(ideb_data[ideb_data$ensino == input$ensino & ideb_data$ano >= input$ensino_ano[1] & ideb_data$ano <= input$ensino_ano[2],]$nota_saeb_media_padronizada), 2))
  })

  output$anos_escolares_taxa_aprovacao <- renderPlot({
    ggplot(ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],] %>% group_by(ano) %>% summarise(taxa_aprovacao = mean(taxa_aprovacao)), aes(x = ano, y = taxa_aprovacao)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(taxa_aprovacao, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Taxa de Aprovação por Ano", x = "Ano", y = "Taxa de Aprovação")
  })

  output$anos_escolares_ideb <- renderPlot({
    ggplot(ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],] %>% group_by(ano) %>% summarise(ideb = mean(ideb)), aes(x = ano, y = ideb)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = round(ideb, 2)), vjust = -1) +
      scale_color_fivethirtyeight() +
      theme_fivethirtyeight() +
      labs(title = "Ideb por Ano", x = "Ano", y = "Ideb")
  })

  output$anos_escolares_nota_saeb_matematica <- renderText({
    paste("Nota Saeb Matemática:", round(mean(ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],]$nota_saeb_matematica), 2))
  })

  output$anos_escolares_nota_saeb_lingua_portuguesa <- renderText({
    paste("Nota Saeb Língua Portuguesa:", round(mean(ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],]$nota_saeb_lingua_portuguesa), 2))
  })

  output$anos_escolares_nota_saeb_media_padronizada <- renderText({
    paste("Nota Saeb Média Padronizada:", round(mean(ideb_data[ideb_data$anos_escolares == input$anos_escolares & ideb_data$ano >= input$anos_escolares_ano[1] & ideb_data$ano <= input$anos_escolares_ano[2],]$nota_saeb_media_padronizada), 2))
  })
}

shinyApp(ui = ui, server = server)
