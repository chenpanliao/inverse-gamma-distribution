# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(MCMCpack)

function(input, output) {
  output$distPlot <- renderPlot({
    alpha <- as.numeric(input$nu) / 2
    beta <- as.numeric(input$V) * as.numeric(input$nu) / 2
    xmax <- 10 ^ as.numeric(input$xmax)
    xseq <- seq(0.00000001, xmax, length.out = 5000)
    DV.pdf <- MCMCpack::dinvgamma(xseq, shape = alpha, scale = beta)
    DV.cdf <- cumsum(DV.pdf) * (xseq[2] - xseq[1])
    par(mfrow = c(2, 1), las = 1)
    plot(
      DV.pdf ~ xseq,
      type = "l",
      xlab = "x",
      ylab = "",
      ylim = c(0, max(DV.pdf)),
      main = paste0(
        "PDF of inverse-gamma distribution (α = ",
        alpha,
        ", β = ",
        beta,
        ")"
      )
    )
    plot(
      DV.cdf ~ xseq,
      type = "l",
      xlab = "x",
      ylab = "",
      ylim = c(0, max(DV.cdf)),
      main = paste0(
        "CDF of inverse-gamma distribution (α = ",
        alpha,
        ", β = ",
        beta,
        ")"
      )
    )
  })
}
