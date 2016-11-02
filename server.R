# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(MCMCpack)

function(input, output) {
  # selected.V <- reactive({input$V})
  # selected.nu <- reactive({input$nu})
  # selected.xmax <- reactive({input$xmax})
  # alpha <- selected.nu() / 2
  # beta <- selected.V() * selected.nu() / 2
  # xseq <- seq(0, selected.xmax(), length.out = 2000)
  output$distPlot <- renderPlot({
    alpha <- as.numeric(input$nu) / 2
    beta <- as.numeric(input$V) * as.numeric(input$nu) / 2
    xseq <- seq(0, as.numeric(input$xmax), length.out = 2000)
    DV <- MCMCpack::dinvgamma(xseq, shape = alpha, scale = beta)
    plot(DV ~ xseq,
         type = "l",
         xlab = "x",
         ylab = "Probability density")
  })
}


# https://en.wikipedia.org/wiki/Inverse-Wishart_distribution
# A univariate specialization of the inverse-Wishart distribution is the
# inverse-gamma distribution. With p=1 (i.e. univariate) and \alpha = \nu/2,
# \beta = \mathbf{\Psi}/2 and x=\mathbf{X} the probability density function
# of the inverse-Wishart distribution becomes

# https://en.wikipedia.org/wiki/Inverse-gamma_distribution
# Inv-Gamma(alpha, beta)

# alpha = nu / 2
# beta = V * nu / 2

# nu = alpha * 2
# V = beta / alpha

# An inverse gamma random variable with shape a and scale b has
# mean b/(a-1) (assuming a>1) and
# variance (b^2)/((a-1)^2 (a-2)) (assuming a>2).
# The parameterization is consistent with the Gamma Distribution in the stats package.
