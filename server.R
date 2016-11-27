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
library(magrittr)

function(input, output) {
  output$distPlot <- renderPlot({
    alpha <- as.numeric(input$nu) / 2
    beta <- as.numeric(input$V) * as.numeric(input$nu) / 2
    xmax <- 10 ^ as.numeric(input$xmax)
    x.mode <- beta / (1 + alpha)
    xseq <- 
      seq(.Machine$double.eps, xmax, length.out = 2000) %>%
      append(., seq(0.5 * x.mode, 1.5 * x.mode, length = 500)) %>%
      sort %>%
      .[which({.} <= xmax)]
    DV.pdf <- invgamma::dinvgamma(xseq, shape = alpha, rate = beta)
    DV.cdf <- invgamma::pinvgamma(xseq, shape = alpha, rate = beta)
    y.tick <- pretty(DV.pdf)
    ylim.max <- y.tick %>% .[length(.)]
    cex.val <- 16 / 12
    col.axis2 <- 4
    col.axis4 <- 2
    par(
      las = 1,
      mar = c(2, 5, 4, 5),
      cex = cex.val,
      mgp = c(3.5, 1, 0),
      yaxs = "i",
      xpd = T
    )
    plot(
      NULL,
      xlab = "x",
      ylab = "Probability density",
      xlim = c(0, xmax),
      ylim = c(0, ylim.max),
      yaxt = "n"
    )
    title(
      main = paste0(
        "PDF/CDF of\ninverse-gamma distribution\n(α = ",
        alpha,
        ", β = ",
        beta,
        ")"
      ),
      adj = 0,
      font.main = 1,
      cex.main = 1
    )
    axis(2,
         y.tick,
         y.tick,
         col = col.axis2,
         col.axis = col.axis2)
    axis(
      4,
      seq(0, ylim.max, length = 6),
      seq(0, 1, length = 6),
      col = col.axis4,
      col.axis = col.axis4
    )
    lines(xseq,
          DV.pdf,
          type = "l",
          col = col.axis2,
          lwd = 3)
    lines(xseq, DV.cdf * ylim.max, col = col.axis4, lwd = 3)
    par(las = 3)
    mtext(
      "Cumulative probability",
      4,
      cex = cex.val,
      line = 3.5,
      col = col.axis4
    )
    legend(
      "topright",
      lwd = 3,
      lty = 1,
      col = c(col.axis2, col.axis4),
      legend = c("PDF", "CDF"),
      inset = c(0, -0.17)
    )
  })
}
