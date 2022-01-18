#Server

library(shiny)
library(magrittr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)

# load brewery data CSV file
brew <- read.csv('Breweries.csv', encoding = 'UTF-8') %>% 
  # trim white space around the state abbreviation
  mutate(State=str_trim(State))

# load beer data from CSV file
beer <- read.csv('Beers.csv',  encoding = 'UTF-8')

# merge beer and brewery datasets
bb = merge(beer, brew, by.x ="Brewery_id", by.y = "Brew_ID")

# only ABV missing values removed
bb_clean_ABV <- bb %>% filter(!is.na(ABV))

# only IBU missing values removed
bb_clean_IBU <- bb %>% filter(!is.na(IBU))

# both ABV and IBU missing values removed
bb_clean <- bb %>% filter(!is.na(ABV) & !is.na(IBU))

colnames(bb)[2] = "Beer_Name"
colnames(bb)[8] = "Brewery_Name"

server = function(input, output){
  
  
  output$distPlot = renderPlot({
    #IBU SELECTED
    if(input$select_data == "ibu"){
      #STATE SELECTION
      if(input$select_state == "all"){x = bb_clean_IBU$IBU}
      else{x = (bb_clean_IBU %>% filter(State == input$select_state))$IBU }
      
      if(input$select_plot == "hist"){
        bins = seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = "#75AADB", border = "white",
             xlab = "IBU",
             main = "IBU Histogram")
      }
      if(input$select_plot == "box"){
        boxplot(x, col = "#75AADB", border = "black",
                xlab = "IBU",
                main = "IBU Boxplot")
      }
    }
    #ABV SELECTED
    if(input$select_data == "abv"){
      if(input$select_state == "all"){x = bb_clean_ABV$ABV}
      else{x = (bb_clean_ABV %>% filter(State == input$select_state))$ABV }
      if(input$select_plot == "hist"){
        bins = seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = "#75AADB", border = "white",
             xlab = "ABV",
             main = "ABV Histogram")
      }
      if(input$select_plot == "box"){
        boxplot(x, col = "#75AADB", border = "black",
                xlab = "ABV",
                main = "ABV Boxplot")
      }
    }
    #IBUvABV SELECTED
    if(input$select_data == "ibu_abv"){
      if(input$select_state == "all"){
        x = bb_clean$ABV
        y = bb_clean$IBU
      }
      else{
        x = (bb_clean %>% filter(State == input$select_state))$ABV
        y = (bb_clean %>% filter(State == input$select_state))$IBU
      }
      if(input$select_model == "y_linear"){
        plot(x, y, col = "#75AADB", pch = 20,
             xlab = "ABV",
             ylab = "IBU",
             main = "IBU v ABV")
        abline(lm(y~x))
      }
      if(input$select_model == "n_linear"){
        plot(x, y, col = "#75AADB", pch = 20,
             xlab = "ABV",
             ylab = "IBU",
             main = "IBU v ABV")
      }
    }
  })
}