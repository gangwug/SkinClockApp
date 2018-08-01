library(shiny)
#library(plotly)
shinyUI(fluidPage(
  titlePanel(h3("Clock genes in human epidermis") ),
  sidebarLayout(
    sidebarPanel(
     fluidRow(
       column(3,
              checkboxGroupInput(inputId = "subjectA", label=h5("Subjects"), 
                                 choices=list("S101", "S102", "S103", "S104", "S105",
                                              "S106", "S107", "S108", "S109", "S110") ) ),
       column(3,
              checkboxGroupInput(inputId = "subjectB", label=h1("\n"), 
                                 choices=list("S111", "S112", "S113", "S114", "S116", 
                                              "S117", "S118", "S119", "S120") ) )
     )
  ),
    mainPanel(
      plotOutput("plot"),
      hr(),
      helpText(h4('For more information, please take a look at the paper:
                 Population level rhythms in human skin: implications for circadian medicine. bioRxiv. 2018, doi: https://doi.org/10.1101/301820.') )
    )
  )
))
