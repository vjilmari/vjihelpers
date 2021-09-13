#' Fixed effects from linear mixed model
#'
#' @param model fitted model with lmerTest function
#' @param ci.level width of confidence intervals
#'
#' @return A fromatted data frame of fixed effects
#' @export
#'
#' @examples
#' set.seed(234)
#' n1=3 #groups
#' n2=3 #observations per groups
#'
#' dat<-data.frame(group=rep(c(LETTERS[1:n1]),each=n2),
#' x1=sample(1:5,n1*n2,replace=TRUE),
#' x2=sample(1:5,n1*n2,replace=TRUE),
#' x3=sample(1:5,n1*n2,replace=TRUE))
#' getFE(lmerTest::lmer(x1~x2+x3+(1|group),data=dat,REML=FALSE))
getFE<-function(model,ci.level=.95){
  p.cut<-1-((1-ci.level)/2)

  coefs<-data.frame(summary(model)$coefficients)
  coefs$lower<-coefs[,1]-stats::qt(p=p.cut,df=coefs[,"df"])*coefs[,2]
  coefs$upper<-coefs[,1]+stats::qt(p=p.cut,df=coefs[,"df"])*coefs[,2]
  coefs<-cbind.data.frame(round(coefs[,1:4],2),
                          p=round(coefs[,5],3),
                          LL=round(coefs$lower,2),
                          UL=round(coefs$upper,2))
  colnames(coefs)<-
    c("Est.","SE","df","t","p","LL","UL")

  return(coefs)
}
