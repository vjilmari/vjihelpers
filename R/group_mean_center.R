#' Returns data including group means and group mean centered variables
#'
#' @param data
#' @param group.var
#' @param vars
#' @param grand.init
#'
#' @return
#' @export
#' @examples
group_mean_center<-function(data,
                            group.var,
                            vars,
                            grand.init=FALSE){

  if (grand.init){
    data[,vars]<-sapply(data[,vars],center)
  }

  group.data<-
    stats::aggregate(data[, vars],
                     list(dat[,group.var]), mean)


  join_vars <- colnames(group.data)[1]
  names(join_vars) <- group.var

  cdata<-dplyr::left_join(
    x=data,
    y=group.data,
    by=join_vars,
    suffix=c("",paste0(".gm")))

  c.vars<-paste0(vars,".gmc")
  g.vars<-paste0(vars,".gm")

  for (i in 1:length(vars)){
    cdata[,c.vars[i]]<-cdata[,vars[i]]-cdata[,g.vars[i]]
  }

  return(cdata)

}
