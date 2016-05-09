library(shiny)
library(reshape2)

mpgLM <- lm(mpg ~ 1, data = mtcars)

shinyServer(function(input, output) {
    output$regressors <- reactive({
        if(length(input$regressors) > 0)
            input$regressors
        else
            c('NA')
    })
    
    output$formula <- reactive({
        if(length(input$regressors > 0))
            paste('mpg ~', paste(input$regressors, collapse = '+'))
        else
            c('mpg ~ 1')
    })
    
    output$coeff <- renderPrint({
        if(length(input$regressors) > 0) 
            mpgLM <<- lm(eval(paste('mpg ~', paste(input$regressors, collapse = '+'))), data = mtcars)
        else 
            mpgLM <<- lm(mpg ~ 1, data = mtcars)
        melt(coef(mpgLM))
    })

    output$r <- reactive({
        if(length(input$regressors) > 0)
            summary(mpgLM)$r.squared
        else
            c('NA')
    })
    
    output$radj <- reactive({
        if(length(input$regressors) > 0)
            summary(mpgLM)$adj.r.squared
        else
            c('NA')
    })
    
    output$qqplot <- renderPlot({
        #I had to put this if otherwise the plot wouldn't update
        if(length(input$regressors) > -1)
            plot(mpgLM, which = 2, sub = NA)
    })
})