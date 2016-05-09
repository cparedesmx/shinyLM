library(shiny)

vars <- names(mtcars)[-1]

shinyUI(pageWithSidebar(
    headerPanel('Interactive Linear Regression Model'),
    sidebarPanel(
        checkboxGroupInput(inputId = 'regressors', label = h3('Regressors:'), 
                           choices = vars),
        helpText('This shiny app fits a linear model (lm) for mpg using the 
                 mtcars dataset. Select the desired confounding regressors above 
                 and it will return the formula, coefficients, r-squared values and 
                 QQ plot of residuals.', p(),
                 'The R code behind this app can be found on', 
                 a('GitHub',href='https://github.com/cparedesmx/shinyLM',target='_blank'))
    ),
    mainPanel(
        h3('Selected regressors:'),
        verbatimTextOutput('regressors'),
        h3('Formula passed to lm:'),
        verbatimTextOutput('formula'),
        h3('Coefficients:'),
        verbatimTextOutput('coeff'),
        h3('R-squared values'),
        p('R-squared:'),
        verbatimTextOutput('r'),
        p('Adjusted R-squared:'),
        verbatimTextOutput('radj'),
        h3('Standardized residuals QQ plot'),
        plotOutput('qqplot')
    )
))