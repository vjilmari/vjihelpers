#' Standardizing helper
#'
#' @param x Numeric variable.
#' @param na.rm Logical. Should missing values be removed. Default TRUE.
#'
#' @return Standardized numeric variable.
#' @export
#'
#' @examples na_standardize(c(1,4,2,5,7))
na_standardize<-
  function(x,na.rm=TRUE){
  (x-mean(x,na.rm=na.rm))/stats::sd(x,na.rm=na.rm)
}
