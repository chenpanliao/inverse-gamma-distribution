# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


# invgamma::dinvgamma(1:5, shape = 2, rate = 4)
# same
# MCMCpack::dinvgamma(1:5, shape = 2, scale = 4)
# invgamma::dinvgamma 的 rate 是 MCMCpack::dinvgamma 的 scale

library(shiny)
library(invgamma)
# require(MCMCpack)

function(input, output) {
  output$distPlot <- renderPlot({
    alpha <- as.numeric(input$nu) / 2
    beta <- as.numeric(input$V) * as.numeric(input$nu) / 2
    xmax <- 10 ^ as.numeric(input$xmax)
    xseq <- seq(0.00000001, xmax, length.out = 5000)
    DV.pdf <- invgamma::dinvgamma(xseq, shape = alpha, rate = beta)
    # DV.cdf <- cumsum(DV.pdf) * (xseq[2] - xseq[1])
    DV.cdf <- invgamma::pinvgamma(xseq, shape = alpha, rate = beta)
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
      ylim = c(0, 1),
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
