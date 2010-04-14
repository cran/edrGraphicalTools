plot.edr <-
function(x,...){
if (!inherits(x, "edr")) stop("use only with \"edr\" objects")

ylab<-"Y"


if(x$K<=2){
for(i in 1:x$K){
dev.new()
matTravail<-x$X%*%x$matEDR[,i]
xlab<-paste("X'EDR",i)
plot(x$Y~matTravail,xlab=xlab,ylab=ylab)
lines(ksmooth(matTravail,x$Y, "normal", bandwidth=0.5), col=3)
}
}else{
dev.new()
name.var <- c("Y",paste("X'EDR",1:x$K,sep="")) 
panel.smooth1<-function(x,y){panel.smooth(x,y,span=0.2)}
pairs(cbind(x$Y,x$X%*%x$matEDR[,1:x$K]),panel=panel.smooth1,lower.panel=NULL,labels=name.var)
}

if(x$K==2){
X1<-x$X%*%x$matEDR[,1]
X2<-x$X%*%x$matEDR[,2]
X1new <- seq(min(X1), max(X1), len=50)
X2new <- seq(min(X2), max(X2), len=50)
newdata <- expand.grid(X1=X1new,X2=X2new)
mod.lo<-loess(x$Y ~ X1 + X2, span=.5, degree=2)
fit <- matrix(predict(mod.lo, newdata), 50, 50)
persp3d(X1new, X2new, fit,xlab="X1'EDR1", ylab="X2'EDR2", zlab=ylab, zlim=range(c(fit,x$Y)), col="lightblue")
points3d(X1,X2,x$Y, col = "red", pch =1)
}

}

