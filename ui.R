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

fluidPage(titlePanel("Inverse Gamma Distribution"),
          sidebarLayout(
            sidebarPanel(
              helpText(
                HTML(
                  "<p>This Shiny app provide the visualized PDF/CDF of inverse gamma distribution, which is used for prior of G-/R- structure for MCMCglmm users. See <a href = 'https://en.wikipedia.org/wiki/Inverse-gamma_distribution'>Inverse Gamma Distribution @ Wikipedia</a> to know the details.</p><p>Auther: Chen-Pan Liao <code>andrew.43@gmail.com</code></p>"
                )
              ),
              numericInput(
                "V",
                "Expected value of variance (V) = β / α",
                1,
                min = 0.0001,
                max = 10000
              ),
              numericInput(
                "nu",
                "Degree of belief parameter (nu) = α * 2",
                1,
                min = 0.0002,
                max = 100
              ),
              sliderInput(
                "xmax",
                "Maximal x-axis value",
                min = -4,
                max = 9,
                value = 1,
                step = 0.1,
                pre = "10 ^ (",
                post = ")",
                sep = ""
              )
            ),
            mainPanel(plotOutput('distPlot', height = "500px"))
          ))
