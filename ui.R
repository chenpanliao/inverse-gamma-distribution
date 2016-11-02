# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# alpha = nu / 2
# beta = V * nu / 2
# V = beta / alpha
# nu = alpha * 2

library(shiny)



fluidPage(verticalLayout(
  titlePanel(
    "Inverse Gamma Distribution (visualization of prior of G-/R- structure for MCMCglmm users)"
  ),
  wellPanel(
    helpText(
      HTML(
        "<p>See <a href = 'https://en.wikipedia.org/wiki/Inverse-gamma_distribution'>Inverse Gamma Distribution @ Wikipedia</a> to know the details.</p><p>Auther: Chen-Pan Liao <code>andrew.43@gmail.com</code></p>"
      )
    ),
    selectInput(
      'V',
      'Expected value of variance (V) = beta / alpha',
      as.character(c(0.1, 1, 2, 5, 10, 20, 50, 100)),
      selected = 1
    ),
    selectInput(
      'nu',
      'Degree of belief parameter (nu) = alpha * 2',
      as.character(c(
        sprintf("%1.4f", 0.0002),
        0.002,
        0.002,
        0.02,
        0.2,
        1,
        2,
        5,
        10,
        20,
        100
      )),
      selected = 0.2
    ),
    sliderInput(
      "xmax",
      "Maximal x-axis value",
      min = 0.1,
      max = 1000,
      value = 10
    )
  ),
  plotOutput('distPlot')
))
