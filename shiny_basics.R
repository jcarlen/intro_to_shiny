# Intro to Shiny Architecture
# Jane Carlen, March 15 2019

# Closely following RStudio's 3-Part How to start with Shiny, by Garrett Grolemund:
# https://shiny.rstudio.com/tutorial/

# I gathered slides and code into one condensed version
# Highlighted annotation in the slides are my additions

# -------------------------------------------------------------------------------------------------
# Examples

# Thanks to Ryan Peek and Rich Pauloo for suggestions

# General catalog
# http://shiny.rstudio.com/gallery/

# Simple
# http://shiny.rstudio.com/gallery/kmeans-example.html
# http://shiny.cws.ucdavis.edu/shiny/rapeek/Gosner_photos/

# Medium
# https://richpauloo.shinyapps.io/tds_leaflet/
# http://shiny.rstudio.com/gallery/movie-explorer.html

# Complex
# http://ucwater.org/gw_obs/ # multiples tabs, types of data, linked data

# -------------------------------------------------------------------------------------------------
# 0. Setup ----

# Load (and install as necessary) packages
for (pkg in c("shiny")) {
  if(!pkg %in% names(installed.packages()[,1])) {
    install.packages(pkg)
  }
  require(pkg, character.only = TRUE)
}

# 1. Basic components of a shiny app ----

  # ui and server functions ----

  # open code/01-template.R and click "Run App"
  # add a text element to fluidPage and run again
  # note the output of fluid page -- fluid page is just one way to structure your ui
  fluidPage("text")

  #"input" and "output" lists ----

  # ui and server communitate with "input" and "output" lists

# 2. Reactivity (part 1) ----

# reactivity loosely means when inputs update, outputs update

# open 02-hist-app.R

# 3. Sharing an app ----

# Two easy ways to share:

# 1. Publicly -- create an account with https://www.shinyapps.io/

# Then in RStudio go to Preferences/Publishing and click connect to connect your ShinyApps.io account
# Allows a limited number of users (active hours) and applications for free

# 2. Privately -- requiring no R knowledge from olleagues

### Share by launching from command line

# see: https://shiny.rstudio.com/articles/running.html

# R -e "shiny::runApp('[path to app.R]')"
# R -e "shiny::runApp('~/Documents/DSI/intro_to_shiny/code/02-hist-app.R')"

#By default runApp starts the application on a randomly selected port. For example, it might start on port 4700, in which case you can connect to the running application by navigating your browser to http://localhost:4700.

#This will show up in the console as the last four digits of, e.g., "Listening on http://127.0.0.1:7951"

# 4. Reactivity (part II) ----

# observeEvent vs. eventReactive

# "Use observeEvent whenever you want to perform an action in response to an event. (Note that "recalculate a value" does not generally count as performing an action–see eventReactive for that.)"

# observeEvent's second argument is "handlerExpr", "This should be a side-effect-producing action (the return value will be ignored). It will be executed within an isolate scope."

# eventReactive's second argument is "valueExpr", "The expression that produces the return value of the eventReactive. It will be executed within an isolate scope."

# 5. Customizing UI ----

# What happens when we enter this in the console?
sliderInput(inputId = "num",
            label = "Choose a number",
            value = 25, min = 1, max = 100)

?shiny::builder

# 6. Simple example with plotly ----
shinyApp(
  
  ui = fluidPage(plotlyOutput("plot")), 
  
  server = function(input, output){
           output$plot = plotly::renderPlotly(ggplot(mtcars, aes(x = mpg)) + geom_histogram())
  }
)
