
<!-- README.md is generated from README.Rmd. Please edit that file -->

# targetedordertest

<!-- badges: start -->

<!-- badges: end -->

Targeted tests for orderings seek to reject the null hypothesis of
uniform randomness, drawing statistical power from a “targeted”
alternative hypothesis that specifies the type of non-randomness
expected in the orderings. The Linear Concordance and Rank Compatibility
tests of [Grant, Perlman, and
Grant, 2020](https://www.sciencedirect.com/science/article/abs/pii/S0378375818300867)
are implemented in this package.

## Installation

<!-- You can install the released version of targetedordertest from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("targetedordertest") -->

<!-- ``` -->

Until this package is accepted into CRAN, you can install it with
`devtools::install_github('SheridanLGrant/targetedordertest')`.

## Example

The following code reproduces the results for the Railroad Commissioner
race in Table 7 of Grant, Perlman, and Grant, 2020.

``` r
library(tidyverse)
library(targetedordertest)

railroadcommissioner %>%
  drop_na() %>%
  select(-County) ->
  rrc

alt <- list(list(c('Berger', 'Boyuls', 'Sitton'),
                 c('Christian')))

rank_compatibility(rrc, alt)
rank_compatibility(rrc, alt, cushion = 10)

scores <- c(2, 2, 4, 2)

linear_concordance(rrc, scores, 'uni')
```
