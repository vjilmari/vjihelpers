#' Two One-Sided Tests for Fixed Effects in Multilevel Models
#'
#' @param model Multilevel model object fitted with lmerTest::lmer.
#' @param fe Character vector. Name of the fixed effect variable.
#' @param bound_l Lower bound based on SESOI (smallest effect size of interest).
#' @param bound_u Upper bound based on SESOI (smallest effect size of interest).
#'
#' @return Vector of test statistics against lower and upper bound.
#' @export
#'
#' @examples
#' set.seed(234)
#' n1 <- 3 # groups
#' n2 <- 3 # observations per groups
#'
#' dat <- data.frame(
#'   group = rep(c(LETTERS[1:n1]), each = n2),
#'   x1 = sample(1:5, n1 * n2, replace = TRUE),
#'   x2 = sample(1:5, n1 * n2, replace = TRUE),
#'   x3 = sample(1:5, n1 * n2, replace = TRUE)
#' )
#'
#' tost_ml(
#'   model = lmerTest::lmer(x1 ~ x2 + x3 + (1 | group),
#'     data = dat, REML = FALSE
#'   ),
#'   fe = "x2", bound_l = -0.30, bound_u = 0.30
#' )
tost_ml <- function(model,
                    fe,
                    bound_l,
                    bound_u) {
  # contrast vector
  conts <- as.numeric(names(lme4::fixef(model)) == fe)

  # two-sided test against lower bound
  lower <- lmerTest::contest1D(
    model = model, L = conts,
    confint = TRUE,
    rhs = bound_l
  ) # get t value for test against lower bound

  # two-sided test against upper bound
  upper <- lmerTest::contest1D(
    model = model, L = conts,
    confint = TRUE,
    rhs = bound_u
  ) # get t value for test against upper bound

  # obtain one-sided p-values

  p.lower <- stats::pt(lower$`t value`, lower$df, lower.tail = FALSE)
  p.upper <- stats::pt(upper$`t value`, upper$df, lower.tail = TRUE)

  output <- cbind(
    Estimate = lower$Estimate,
    "Std. Error" = lower$"Std. Error",
    df = lower$df,
    t_lower = lower$"t value",
    t_upper = upper$"t value",
    p_lower = p.lower,
    p_upper = p.upper
  )
  return(output)
}
