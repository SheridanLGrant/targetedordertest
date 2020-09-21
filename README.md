
<!-- README.md is generated from README.Rmd. Please edit that file -->

# targetedordertest

<!-- badges: start -->

<!-- badges: end -->

Targeted tests for orderings seek to reject the null hypothesis of
uniform randomness, drawing statistical power from a “targeted”
alternative hypothesis that specifies the type of non-randomness
expected in the orderings. The Linear Concordance and Rank Compatibility
tests of
[https://www.sciencedirect.com/science/article/abs/pii/S0378375818300867](Grant,%20Perlman,%20and%20Grant,%202020)
are implemented in this package.

## Installation

<!-- You can install the released version of targetedordertest from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("targetedordertest") -->

<!-- ``` -->

Until this package is accepted into CRAN, you can install it with
`install_github(SheridanLGrant/targetedordertest)`.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(targetedordertest)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots.
