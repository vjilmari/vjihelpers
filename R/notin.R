#' Value mismatching
#'
#' @param x Vector: the values to be matched.
#' @param y Vector: the values to be matched against.
#'
#' @return A vector of positions of mismatches.
#' @export
#'
#' @examples
#' notin(c("a"), c("a", "b"))
#' notin(c("a"), c("c", "b"))
notin <- function(x, y) {
  !(x %in% y)
}
