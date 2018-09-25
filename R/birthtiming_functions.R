standardize <- function(x){
  return( (x-mean(x, na.rm=T))/sd(x, na.rm=T) )
}

`%!in%` <- Negate(`%in%`)
