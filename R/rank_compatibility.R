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
      out[((j-1)*nx + 1):(j*nx),
          (nl_cum[i] + 1):nl_cum[i+1]] <- matrix(rep(perms[(j-1)%%nf[i]+1,], nx),
                                                 ncol = nl[i],
                                                 byrow = T)
    }
  }
  return(matrix(out, nrow = n))
}

#' Execute Rank Compatibility test
#'
#' Given a set of orderings, an alternative preference
#' criterion, and a cushion for the number of biased
#' agents, compute the p value for the RC test. Note that
#' alternative must be a list of lists of character
#' vectors.
#'
#' @param .data data.frame
#' @param alternatives list
#' @param cushion double
#'
#' @return list
#' @export
#'
#' @examples
rank_compatibility <- function(.data,
                               alternatives,  # TODO: check admissibility of alternatives
                               cushion = 1) {
  # number of items, orderings, and vector of item names
  m <- ncol(.data)
  n <- nrow(.data)
  items <- colnames(.data)

  # compute compatible orderings and their null probability
  Bs <- lapply(alternatives,
               function(x) expand(x))
  p0 <- sum(sapply(Bs, function(B) nrow(B)/factorial(m)))

  tauHats <- numeric(length(alternatives))
  for (i in 1:n) {
    # increment tauHat if ith ordering is compatible with PC
    tauHats <- tauHats +
      sapply(Bs,
             function(B) any(apply(B, 1,
                                   function(x) identical(x, items[match(1:m,
                                                                        .data[i,])]))))
  }

  pval <- 1
  if (sum(tauHats) >= cushion) {
    pval <- 1 - stats::pbinom(sum(tauHats) - cushion, size = n, prob = p0)
  }
  cat('tauHats:', tauHats, '\n',
      'lower confidence bound, inclusive, for', cushion, ':', pval, '\n')
  return(list(pval = pval, tauHats = tauHats))
}
