library(shiny)

df <- read.csv(file="C:\\Users\\user\\Desktop\\Stock Analysis\\90days_industry_stats.csv", header=TRUE, sep=",")
char_tickers<- as.character(df$ticker)
my_autocomplete_list <- char_tickers

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
  
  
  headerPanel("Stock Explorer"),
  
  sidebarPanel(
    
    helpText("Select a stock to examine. 
             Information will be collected from yahoo finance."),
    
    textInput.typeahead(id="symb",
                        placeholder="Stock code",
                        local=data.frame(name=c(my_autocomplete_list)),
                        valueKey = "name",
                        tokens=c(1:length(my_autocomplete_list)),
                        template = HTML("<p class='repo-language'>{{info}}</p> <p class='repo-name'>{{name}}</p>")
    ),
    
    dateRangeInput("dates", 
                   "Compare to historic returns from",
                   start = Sys.Date()-365, end = Sys.Date()),
    
    actionButton("get", "Get Stock"),
    
    br(),
    br(),
    
    uiOutput("newBox")
    
    ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Charts", plotOutput("chart")), 
      tabPanel("Model", div(h3(textOutput("ks"))), 
               div(h3(textOutput("ksp"))), 
               plotOutput("hist")), 
      # tabPanel("VaR", h3(textOutput("text3"))),
      id = "tab"
    )
  )
))
