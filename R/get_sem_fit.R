#' Obtain lavaan model fit indices
#'
#' @param model Fitted lavaan model.
#' @param round Rounding for the numeric output.
#'
#' @return Fit indices and model statistics.
#' @export
#'
#' @examples
#' set.seed(21417)
#' x <- rnorm(1000)
#'
#' d <- data.frame(
#'   x1 = sqrt(.50) * x + sqrt(1 - .50) * rnorm(1000),
#'   x2 = sqrt(.50) * x + sqrt(1 - .50) * rnorm(1000),
#'   x3 = sqrt(.50) * x + sqrt(1 - .50) * rnorm(1000),
#'   x4 = sqrt(.50) * x + sqrt(1 - .50) * rnorm(1000)
#' )
#'
#' mod <- "X=~x1+x2+x3+x4"
#'
#' fit1 <- lavaan::cfa(mod, d)
#'
#' get_sem_fit(fit1, round = 3)
get_sem_fit <- function(model, round = 6) {
  round(lavaan::inspect(model, "fit")[c(
    "npar", "chisq", "df", "pvalue",
    "cfi", "tli", "rmsea", "srmr"
  )], round)
}
