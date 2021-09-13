#' Simple centering helper
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
center<-function(x){
  x-mean(x,na.rm=T)
}
