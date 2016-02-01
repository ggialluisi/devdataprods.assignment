library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("MPG simulator"),
    
    sidebarPanel(
        
        h3('MPG simulator'),
        p("Our model for estimating MPG is based on three predictors*:"),
        p("- Car Weight;"),
        p("- 1/4 mile time; and"),
        p("- Transmission Type."),
        p("Use the web controls below to change values of this predictors to have MPG predicted."),
        p("You can use the plots to verify how predicted value behaves among the observed values in mtcars dataset."),

        p("-----------------"),
        h4("Select characteristicts to estimate MPG:"),
        sliderInput('wt', 'Car Weight (lb/1000)',value = 3.5, min = 1.5, max = 5.5, step = 0.05,),
        sliderInput('qsec', '1/4 mile time (seconds)',value = 18.75, min = 14.5, max = 23, step = 0.05,),
        radioButtons("am", label = "Transmission Type",
                     choices = list("Automatic" = 0, 
                                    "Manual" = 1), selected = 1),
        p("-----------------"),
        p("* For detailed information about the chosen model visit: http://rpubs.com/ggialluisi/TransmissionTypeInfluenceOnMpg")
        
    ),
    mainPanel(

        h2('MPG simulator'),
        p('MPG prediction (Miles/US gallon): '),
        verbatimTextOutput("mpg_prediction"),
        
        h3('Data visualization'),
        plotOutput('theplot')
        
    )
))

