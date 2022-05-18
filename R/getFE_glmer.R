#' Fixed effects from generalized linear mixed model
#'
#' @param model Fitted model with lme4::glmer.
#' @param ci.level Width of confidence intervals.
#' @param round Rounding for all but p-values (default 2).
#' @param p.round Rounding for p-values (default 3).
#'
#' @return A formatted data frame of fixed effects.
#' @export
#'
#' @examples
#' set.seed(234)
#' n1 <- 3 # groups
#' n2 <- 3 # observations per groups
#'
#' dat <- data.frame(
#'   group = rep(c(LETTERS[1:n1]), each = n2),
#'   x1 = sample(c(0, 1), n1 * n2, replace = TRUE),
#'   x2 = sample(1:5, n1 * n2, replace = TRUE),
#'   x3 = sample(1:5, n1 * n2, replace = TRUE)
#' )
#' getFE_glmer(lme4::glmer(x1 ~ x2 + x3 + (1 | group),
#'   data = dat,
#'   family = binomial(link = "logit")
#' ))
getFE_glmer <-
  function(model, ci.level = 0.95, round = 2, p.round = 3) {
    p.cut <- 1 - ((1 - ci.level) / 2)
    coefs <- data.frame(summary(model)$coefficients)
    coefs$lower <- coefs[, 1] - stats::qnorm(p = p.cut) * coefs[, 2]
    coefs$upper <- coefs[, 1] + stats::qnorm(p = p.cut) * coefs[, 2]
    coefs <- cbind.data.frame(round(coefs[, 1:3], round),
      p = round(coefs[, 4], p.round),
      LL = round(coefs$lower, round),
      UL = round(coefs$upper, round)
    )

    colnames(coefs) <- c(
      "Est.", "SE", "z", "p", "LL",
      "UL"
    )
    return(coefs)
  }
