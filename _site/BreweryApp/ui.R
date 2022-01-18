#UI Brewery App
library(shiny)

ui = fluidPage(
  titlePanel("Brewery Case Study App"),
  sidebarLayout(
    sidebarPanel(
      #Bin Selection
      sliderInput(inputId = "bins",
                  label = "Histogram Bin Slider",
                  min = 1,
                  max = 50,
                  value = 30),
      #Data Selection
      selectInput("select_data", 
                  label = h3("Data Selection"),
                  choices = list("IBU" = "ibu", "ABV" = "abv", "IBU v ABV" = "ibu_abv"),
                  selected = 1),
      #State Input
      selectInput("select_state", 
                  label = h3("State Selection"),
                  choices = list("All" = "all", "Washington" = "WA", "Oregon" = "OR", 
                                 "California" = "CA", "Nevada" = "NV", "Utah" = "UT", 
                                 "Colorado" = "CO", "Wyoming" = "WY", "Montana" = "MT", 
                                 "Idaho" = "ID", "North Dakota" = "ND", "South Dakota" = "SD", 
                                 "Nebraska" = "NE", "Kansas" = "KS", "Minnesota" = "MN", 
                                 "Iowa" = "IA", "Missouri" = "MO", "Wisconsin" = "WI", 
                                 "Michigan" = "MI", "Illinois" = "IL", "Indiana" = "IN", 
                                 "Ohio" = "OH", "Arizona" = "AZ", "New Mexico" = "NM",
                                 "Oklahoma" = "OK", "Texas" = "TX", "Maryland" = "MD", 
                                 "Delware" = "DE", "West Virginia" = "WV", "Virginia" = "VA", 
                                 "Kentucky" = "KY", "Tennessee" = "TN", "North Carolina" = "NC", 
                                 "South Carolina" = "SC", "Georgia" = "GA","Alabama" = "AL", 
                                 "Mississippi" = "MS", "Arkansas" = "AR", "Louisiana" = "LA", 
                                 "Florida" = "FL", "Washington D.C." = "DC", "Pennsylvania" = "PA", 
                                 "New Jersey" = "NJ", "New York" = "NY", "Conneticut" = "CT", 
                                 "Rhode Island" = "RI", "Vermont" = "VT", "Massachusetts" = "MA", 
                                 "New Hampshire" = "NH", "Maine" = "ME", "Hawaii" = "HI", "Alaska" = "AK"),
                  selected = 1),
      #Plot Selection
      selectInput("select_plot", 
                  label = h3("Plot Selection"),
                  choices = list("Histogram" = "hist", "Boxplot" = "box"),
                  selected = 1),
      selectInput("select_model", 
                  label = h3("Overlay Linear Model?"),
                  choices = list("Yes" = "y_linear", "No" = "n_linear"),
                  selected = 1),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value")))
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)