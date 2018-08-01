###load required packages
library(shiny)
library(dplyr)
#library(plotly)
library(ggplot2)
###load the data
dataD = readRDS("skinclock.rds")
dataD$timep = as.numeric(dataD$timep)
dataD$geneID = factor(dataD$geneID, levels = c("ARNTL", "NPAS2", "NR1D2", "HLF", "PER2") )
dataD$subjectID = factor(dataD$subjectID, levels = c( paste("S", c(101:114, 116:120), sep = ""), "Mean") )
###draw the figure
shinyServer(function(input, output) {
  ## get the input selection
  subjectD <- reactive({
    subjects = c("Mean", input$subjectA, input$subjectB)
    return(subjects)
  })
  ## show the figure
  output$plot <- renderPlot({
    selectID = subjectD()
    palette(c(rainbow(19), "blue"))
    figD = dplyr::filter(dataD, subjectID %in% selectID )
    gplot = ggplot(data = figD, aes(x = timep, y = exp, group = subjectID, color = subjectID) ) + 
            geom_point(aes(color = subjectID, shape = subjectID), size = 1.99 ) + 
            geom_line(aes(size = subjectID) ) + facet_wrap(~geneID) + labs(x = "", y = "Exp/Max") + 
            scale_x_continuous(limits = c(0.167, 4.167), breaks = 1:4, labels = c("12pm", "6pm", "12am", "6am") ) + 
            scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by =0.25), labels = seq(0, 1, by =0.25) ) + 
            scale_shape_manual(values= c("S101"=0, "S102"=1, "S103"=2, "S104"=3, "S105"=4, "S106"=5, "S107"=6, "S108"=7, "S109"=8, "S110"=9, 
                                         "S111"=10, "S112"=11, "S113"=12, "S114"=13, "S116"=14, "S117"=15, "S118"=16, "S119"=17, "S120"=18, "Mean"=19) ) +
            scale_size_manual(values = c("S101"=0.6, "S102"=0.6, "S103"=0.6, "S104"=0.6, "S105"=0.6, "S106"=0.6, "S107"=0.6, "S108"=0.6, "S109"=0.6, "S110"=0.6, 
                                         "S111"=0.6, "S112"=0.6, "S113"=0.6, "S114"=0.6, "S116"=0.6, "S117"=0.6, "S118"=0.6, "S119"=0.6, "S120"=0.6, "Mean"=1.35) ) + 
            scale_color_manual(values= c("S101"=1, "S102"=2, "S103"=3, "S104"=4, "S105"=5, "S106"=6, "S107"=7, "S108"=8, "S109"=9, "S110"=10, 
                                         "S111"=11, "S112"=12, "S113"=13, "S114"=14, "S116"=15, "S117"=16, "S118"=17, "S119"=18, "S120"=19, "Mean"=20) ) +
            theme_bw() + theme(axis.text.x = element_text(size = 16.6, angle = 60, hjust = 1), legend.title=element_blank(),
                              axis.text.y = element_text(size = 16.6), strip.text = element_text(size = 19.6, face = "bold"),legend.text=element_text(size=13.6), 
                              axis.title = element_text(size = 19.6, face = "bold"), plot.margin = margin(t=0.1,r=0.05,b=0.05,l=0.1, unit="inches") )
    print(gplot)
  })
})
