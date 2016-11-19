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



fluidPage(
  titlePanel(
    "Inverse Gamma Distribution"
  ),
  sidebarLayout(
    sidebarPanel(
      helpText(
        HTML(
          "<p>This Shiny app provide the visualized PDF/CDF of inverse gamma distribution, which is used for prior of G-/R- structure for MCMCglmm users. See <a href = 'https://en.wikipedia.org/wiki/Inverse-gamma_distribution'>Inverse Gamma Distribution @ Wikipedia</a> to know the details.</p><p>Auther: Chen-Pan Liao <code>andrew.43@gmail.com</code></p>"
        )
      ),
      selectInput(
        'V',
        'Expected value of variance (V) = β / α',
        as.character(c(0.01, 0.25, 1, 4, 16, 25, 100, 225, 400, 900, 2500, 10000)),
        selected = 1
      ),
      selectInput(
        'nu',
        'Degree of belief parameter (nu) = α * 2',
        as.character(c(
          # sprintf("%1.6f", 0.000002),
          sprintf("%1.4f", 0.0002),
          0.002,
          0.02,
          0.2,
          0.4,
          1,
          2,
          5,
          10,
          20,
          100,
          200,
          500
        )),
        selected = 0.2
      ),
      sliderInput(
        "xmax",
        "Maximal x-axis value",
        min = -3,
        max = 5,
        value = 1,
        step = 1,
        pre = "10 ^ (",
        post = ")",
        sep = ""
      )
    ),
    mainPanel(plotOutput('distPlot', height = "500px"))
  )
)
