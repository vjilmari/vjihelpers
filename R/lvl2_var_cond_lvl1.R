#' Variance between level 2 units at different values of level 1 variables.
#'
#' @param model Mixed effect model fitted with lmer. Must include random intercept, slope, and their covariation.
#' @param lvl1.var Level 1 variable name.
#' @param lvl1.values Level 1 variable values.
#'
#' @return Data frame of level 2 variance estimates conditioned on level 1 variable values.
#' @export
#'
#' @examples
#' cdat <- group_mean_center(
#'   data = iris,
#'   vars = c(
#'     "Sepal.Length",
#'     "Sepal.Width",
#'     "Petal.Length",
#'     "Petal.Width"
#'   ),
#'   group.var = "Species",
#'   grand.init = TRUE
#' )
#'
#' fit <- lme4::lmer(Sepal.Length ~ Petal.Length.gmc + (Petal.Length.gmc | Species),
#'   data = cdat, REML = FALSE
#' )
#'
#' lvl2_var_cond_lvl1(
#'   model = fit,
#'   lvl1.var = "Petal.Length.gmc",
#'   lvl1.values = c(-2, -1, 0, 1, 2)
#' )
lvl2_var_cond_lvl1 <- function(model, lvl1.var, lvl1.values) {
  VC.frame <- getVC(model)
  VC.frame[is.na(VC.frame)] <- "empty"


  cond.lvl2.values <- rep(NA, length(lvl1.values))

  for (i in 1:length(lvl1.values)) {
    cond.lvl2.values[i] <-
      VC.frame[VC.frame[, "var1"] == "(Intercept)" &
        VC.frame[, "var2"] == "empty", "vcov"] +
      2 * VC.frame[VC.frame[, "var1"] == "(Intercept)" &
        VC.frame[, "var2"] == lvl1.var, "vcov"] * (lvl1.values[i]) +
      VC.frame[VC.frame[, "var1"] == lvl1.var &
        VC.frame[, "var2"] == "empty", "vcov"] * (lvl1.values[i])^2
  }

  output <- cbind.data.frame(
    lvl1.value = lvl1.values,
    lvl2.cond.var = cond.lvl2.values
  )
  return(output)
}
