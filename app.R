library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Observe priorities"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput(inputId = "text3", label = "Low pr. observer", value = "Pablo"),
            textInput(inputId = "text1", label = "High pr. observer", value = "Hello"),
            textInput(inputId = "text2", label = "Midd pr. observer", value = "my name is"),
            actionButton(inputId = "myButton", label = "Test priority")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            p("Proities are set in observes so we can get an ordered output"),
           verbatimTextOutput(outputId = "myText")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$myText <- renderText({
        
        myResponse()
        
    })

    myResponse <- reactiveVal(value = "")
    observeEvent(input$myButton, {
        
        myResponse(paste(myResponse(), input$text1))
        
    }, ignoreInit = TRUE, priority = 3L)
    
    observeEvent(input$myButton, {
        
        myResponse(paste(myResponse(), input$text2))
        
    }, ignoreInit = TRUE, priority = 2L)
    
    observeEvent(input$myButton, {
        
        myResponse(paste(myResponse(), input$text3, "\n"))
        
    }, ignoreInit = TRUE, priority = 1L)
}

# Run the application 
shinyApp(ui = ui, server = server)
