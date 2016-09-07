shinyUI(pageWithSidebar(
  headerPanel("Car Milage Calculator!"),
  sidebarPanel(
    h3("Input Car Details"),
    numericInput('wt', 'Car Weight (1000 lbs)', 5, min=1,max=6, step=0.5),
    radioButtons('am', "Automatic?", c("Yes"=0, "No"=1)),
    selectInput('cyl', 'No. of Cylinders', c(4,6,8)),
    selectInput('gear', 'No. of Gear', c(3,4,5)),
    numericInput('carb', 'No. of Carburetors', 1,min=1,max=8, step=1),
    
    submitButton("SUBMIT")
     ),
  
  mainPanel(
    h3("Results Panel"),
    h5("Data Entered"),
    verbatimTextOutput("owt"),
    verbatimTextOutput("oam"),
    verbatimTextOutput("ocyl"),
    verbatimTextOutput("ogear"),
    verbatimTextOutput("ocarb"),
    h3("Predicted Milage (miles/gallon) is"),
    verbatimTextOutput("omil")
  )
))