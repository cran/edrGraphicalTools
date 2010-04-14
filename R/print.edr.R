print.edr <-
function(x,...){
if (!inherits(x, "edr")) stop("use only with \"edr\" objects")

cat(paste("Reduction method performed:", x$method),"\n")
cat(" \n")

cat(paste("Number of observations:", x$n),"\n")
cat(paste("Dimension reduction K:", x$K),"\n")
cat(paste("Number of slices:", x$H),"\n")
cat(" \n")


cat("Result of the estimation of edr direction:\n" )
tmp <- matrix(x$matEDR[,1:x$K],ncol=x$K)
row.names(tmp) <- 1:dim(tmp)[1]
colnames(tmp) <- paste("edr",1:x$K,sep="")
cat("\n")
prmatrix(signif(tmp,3))
cat("\n")

}

