#' Value mismatching
#'
#' @param x vector: the values to be matched
#' @param y vector: the values to be matched against
#'
#' @return a vector of positions of mismatches
#' @export
#'
#' @examples
#' notin(c("a"),c("a","b"))
#' notin(c("a"),c("c","b"))
notin<-function(x,y){
  !(x %in% y)
}
