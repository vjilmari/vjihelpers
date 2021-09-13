
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vjihelpers

<!-- badges: start -->
<!-- badges: end -->

The goal of vjihelpers is to combine multiple helper and utility
functions to same package.

## Installation

You can install the released version of vjihelpers from
[CRAN](https://CRAN.R-project.org) with:

-   There is no CRAN version available

``` r
install.packages("vjihelpers")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("vjilmari/vjihelpers")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(vjihelpers)
## basic example code

#generate multigroup numeric data
set.seed(234)
n1=3 #groups
n2=3 #observations per groups

dat<-data.frame(
  group=rep(c(LETTERS[1:n1]),each=n2),
  x1=sample(1:5,9,replace=TRUE),
  x2=sample(1:5,9,replace=TRUE),
  x3=sample(1:5,9,replace=TRUE))

group_mean_center(data=dat,group.var = "group",
                  vars = c("x1","x2","x3"))
#>   group x1 x2 x3    x1.gm    x2.gm    x3.gm     x1.gmc     x2.gmc     x3.gmc
#> 1     A  1  2  5 1.666667 3.000000 3.333333 -0.6666667 -1.0000000  1.6666667
#> 2     A  2  2  2 1.666667 3.000000 3.333333  0.3333333 -1.0000000 -1.3333333
#> 3     A  2  5  3 1.666667 3.000000 3.333333  0.3333333  2.0000000 -0.3333333
#> 4     B  2  1  2 2.666667 2.333333 2.000000 -0.6666667 -1.3333333  0.0000000
#> 5     B  5  3  2 2.666667 2.333333 2.000000  2.3333333  0.6666667  0.0000000
#> 6     B  1  3  2 2.666667 2.333333 2.000000 -1.6666667  0.6666667  0.0000000
#> 7     C  4  1  4 3.666667 3.333333 3.333333  0.3333333 -2.3333333  0.6666667
#> 8     C  4  5  3 3.666667 3.333333 3.333333  0.3333333  1.6666667 -0.3333333
#> 9     C  3  4  3 3.666667 3.333333 3.333333 -0.6666667  0.6666667 -0.3333333
```
