#' Returns data including group means and group mean centered variables
#'
#' @param data Data frame of individual observations across multiple groups.
#' @param group.var Character string name of the grouping variable.
#' @param vars Vector of numeric variable names to be centered.
#' @param grand.init Is initial grand mean centering to each variable applied (default FALSE)?
#'
#' @return Data frame with group means and variables centered around group means.
#' @export
#' @examples
#' set.seed(234)
#' n1 <- 3 # groups
#' n2 <- 3 # observations per groups
#' dat <- data.frame(
#'   group = rep(c(LETTERS[1:n1]), each = n2),
#'   x1 = sample(1:5, n1 * n2, replace = TRUE),
#'   x2 = sample(1:5, n1 * n2, replace = TRUE),
#'   x3 = sample(1:5, n1 * n2, replace = TRUE)
#' )
#'
#' group_mean_center(
#'   data = dat, group.var = "group",
#'   vars = c("x1", "x2", "x3")
#' )
group_mean_center <- function(data,
                              group.var,
                              vars,
                              grand.init = FALSE) {
  if (grand.init) {
    data[, vars] <- sapply(data[, vars], center)
  }

  group.data <-
    stats::aggregate(
      data[, vars],
      list(data[, group.var]), mean
    )

  # automatically names as x if only one vars
  if (length(vars)==1){
    names(group.data)<-c(names(group.data[1]),vars)
  }


  join_vars <- colnames(group.data)[1]
  names(join_vars) <- group.var

  cdata <- dplyr::left_join(
    x = data,
    y = group.data,
    by = join_vars,
    suffix = c("", paste0(".gm"))
  )

  c.vars <- paste0(vars, ".gmc")
  g.vars <- paste0(vars, ".gm")

  for (i in 1:length(vars)) {
    cdata[, c.vars[i]] <- cdata[, vars[i]] - cdata[, g.vars[i]]
  }

  return(cdata)
}
