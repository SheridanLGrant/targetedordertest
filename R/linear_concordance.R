#' Execute Linear Concordance Test
#'
#' Given a set of orderings and a user-specified score vector,
#' execute either the uni- or bi-directional LC test
#'
#' @param .data data.frame
#' @param scores double
#' @param direction character
#'
#' @return double
#' @export
#'
#' @examples
linear_concordance <- function(.data, scores, direction = 'uni') {
  orderings <- as.matrix(.data)
  n <- nrow(orderings)
  k <- ncol(orderings)
  s <- scores - mean(scores)
  if (direction == 'uni') {
    conc <- orderings %*% s
    tBar <- mean(conc)
    se <- sqrt(sum(s^2)* k*(k + 1)/12 / n)
    z <- tBar / se
    cat('Observed Mean:', tBar, 'and SE:', se, '\n')
    cat('z-statistic:', z, '\n')
    cat('1-sided p-value:', 1 - stats::pnorm(z), '\n')
  } else if (direction == 'bi') {
    conc <- (orderings %*% s)^2
    tTilde <- mean(conc)
    null_mean <- sum(s^2)*k*(k+1)/12
    psi <- k*(k+1)/360*((5*k^2 - k - 9)*(sum(s^2)^2) - 3*k*(k+1)*sum(s^4))
    se <- sqrt(psi / n)
    z <- (tTilde - null_mean) / se
    cat('Observed Mean:', tTilde, 'and Gamma(s):', null_mean, 'and SE:', se, '\n')
    cat('z-statistic:', z, '\n')
    cat('1-sided p-value:', 1 - stats::pnorm(z), '\n')
  } else {
    stop('direction must be either "uni" or "bi"')
  }
  return(pval = 1 - pnorm(z))
}
