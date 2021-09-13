#' Simple centering helper
#'
#' @param x numeric variable
#' @param na.rm remove missing values? (default TRUE)
#'
#' @return numeric variable centered around its mean
#' @export
#'
#' @examples center(c(1, 2, 3, 5, 3, 2), na.rm = TRUE)
#' center(c(1, NA, NA, 5, 3, 2), na.rm = TRUE)
center <- function(x, na.rm = TRUE) {
  x - mean(x, na.rm = na.rm)
}
