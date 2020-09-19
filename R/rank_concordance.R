#' Expand a partially ordered list
#'
#' Compute all vectors of m elements that are compatible with
#' a given partial ordering of the m elements.
#'
#' @param vectors list
#'
#' @return matrix
#' @export
#'
#' @examples
expand <- function(vectors) {
  m <- sum(sapply(vectors, length))
  nl <- sapply(vectors, length)
  nl_cum <- c(0, cumsum(nl))
  nf <- sapply(nl, factorial)
  n <- prod(nf)
  out <- matrix(0, nrow = n, ncol = m)
  nx <- n
  ny <- 1
  for (i in 1:length(vectors)) {
    perms <- gtools::permutations(nl[i], nl[i], vectors[[i]])
    nx <- nx / nf[i]
    ny <- ny * nf[i]
    for (j in 1:ny) {
      out[((j-1)*nx + 1):(j*nx),(nl_cum[i] + 1):nl_cum[i+1]] <- matrix(rep(perms[(j-1)%%nf[i]+1,],
                                                                           nx),
                                                                       ncol = nl[i],
                                                                       byrow = T)
    }
  }
  return(matrix(out, nrow = n))
}

#' Execute Rank Concordance test
#'
#' Given a set of orderings, an alternative preference
#' criterion, and a cushion for the number of biased
#' agents, compute the p value for the RC test.
#'
#' @param .data data.frame
#' @param alternative list
#' @param cushion double
#'
#' @return double
#' @export
#'
#' @examples
rank_concordance <- function(.data,
                             alternative,
                             cushion = 1) {
  B <- expand(alternative)
  B <- matrix(apply(B, 2, as.character), nrow = nrow(B))
  m <- ncol(.data)
  n <- nrow(.data)
  p1 <- nrow(B)/factorial(ncol(B))
  tauHat <- 0
  for (i in 1:n) {
    if (any(apply(B,
                  1,
                  function(x) identical(x, colnames(.data)[match(1:m, .data[i,])])))) {
      tauHat <- tauHat + 1
    }
  }
  if (tauHat < cushion) {
    pval <- 1
  } else {
    pval <- 1 - sum(stats::dbinom(0:(tauHat-cushion), size = n, prob = p1))
    cat('tauHat:', tauHat, '\n',
        'lower confidence bound, inclusive, for', cushion, ':', pval, '\n')
    return(pval)
  }
}
