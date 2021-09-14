
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vjihelpers

<!-- badges: start -->
<!-- badges: end -->

The goal of vjihelpers is to combine multiple helper and utility
functions to same package.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("vjilmari/vjihelpers")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(vjihelpers)
## basic example code

# generate multigroup numeric data
set.seed(234)
n1 <- 3 # groups
n2 <- 3 # observations per groups

dat <- data.frame(
  group = rep(c(LETTERS[1:n1]), each = n2),
  x1 = sample(1:5, n1 * n2, replace = TRUE),
  x2 = sample(1:5, n1 * n2, replace = TRUE),
  x3 = sample(1:5, n1 * n2, replace = TRUE)
)

group_mean_center(
  data = dat, group.var = "group",
  vars = c("x1", "x2", "x3")
)
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
getFE(lmerTest::lmer(x1 ~ x2 + x3 + (1 | group), data = dat, REML = F),
  ci.level = .80
)
#>              Est.   SE   df     t     p    LL   UL
#> (Intercept)  2.71 1.69 8.04  1.60 0.147  0.35 5.07
#> x2           0.12 0.30 7.33  0.42 0.689 -0.29 0.54
#> x3          -0.14 0.44 8.81 -0.31 0.762 -0.75 0.48
cdat <- group_mean_center(
  data = iris,
  vars = c(
    "Sepal.Length",
    "Sepal.Width",
    "Petal.Length",
    "Petal.Width"
  ),
  group.var = "Species",
  grand.init = TRUE
)
fit <- lme4::lmer(Sepal.Length ~ Petal.Length.gmc + (Petal.Length.gmc | Species),
  data = cdat, REML = FALSE
)
#> boundary (singular) fit: see ?isSingular
lvl2_var_cond_lvl1(
  model = fit,
  lvl1.var = "Petal.Length.gmc",
  lvl1.values = c(-2, -1, 0, 1, 2)
)
#>   lvl1.value lvl2.cond.var
#> 1         -2          0.10
#> 2         -1          0.23
#> 3          0          0.42
#> 4          1          0.67
#> 5          2          0.98
```
