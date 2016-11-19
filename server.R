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
    x.mode <- beta / (1 + alpha)
    xmax <- 10 ^ as.numeric(input$xmax)
    xseq <- seq(.Machine$double.eps, xmax, length.out = 2000)
    # 若選擇的 x 範圍包括峰值位置則強制加入峰值位置
    if (x.mode <= max(xseq)) {
      xseq <-
        xseq %>%
        c(., x.mode) %>%
        sort
    }
    DV.pdf <- invgamma::dinvgamma(xseq, shape = alpha, rate = beta)
    DV.cdf <- invgamma::pinvgamma(xseq, shape = alpha, rate = beta)
    y.tick <- pretty(DV.pdf)
    ylim.max <- y.tick %>% .[length(.)]
    cex.val <- 15 / 12
    col.axis4 <- 2
    par(
      las = 1,
      mar = c(2, 5, 4, 5),
      cex = cex.val,
      mgp = c(4, 1, 0)
    )
    plot(
      DV.pdf ~ xseq,
      type = "l",
      xlab = "x",
      ylab = "Probability density",
      ylim = c(0, ylim.max),
      main = paste0(
        "PDF/CDF of inverse-gamma distribution (α = ",
        alpha,
        ", β = ",
        beta,
        ")"
      )
    )
    axis(
      4,
      seq(0, ylim.max, length = 6),
      seq(0, 1, length = 6),
      col = 2,
      col.axis = 2
    )
    lines(xseq, DV.cdf * ylim.max, col = col.axis4)
    par(las = 3)
    mtext(
      "Cumulative probability",
      4,
      cex = cex.val,
      line = 4,
      col = col.axis4
    )
  })
}
