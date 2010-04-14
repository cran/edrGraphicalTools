edr <-
function(Y,X,H,K,method){
cl <- match.call()
args <- as.list(match.call(edr))[-1]

if((any(is.na(X))==T)|(any(is.na(Y))==T))stop("The data should not contained missing value")
if(length(Y)!=dim(X)[1]) stop("Y and X should have the same number of row")
n<-length(Y)
p<-ncol(X)
if(missing(H))stop("The number of slices should be specified")
if(missing(K))stop("The dimension of the reduction should be specified ")
if(missing(method))stop("the method should be specified")
if(!(method %in% c("SIR-I","SIR-II","SAVE")))stop("the method should be specified by SIR-I or SIR-II or SAVE")

sigma<-((n-1)/n)*var(X)

moyX<-matrix(apply(X,2,mean),ncol=1)

nbind<-rep(n%/%H,H) # number of subject in each slices
if((n%/%H)*H!=n){
ad<-rep(1,H)
ad[sample(H,H-(n-(n%/%H)*H))]<-0
nbind<-nbind+ad}

#standardization of X : Xstd
res<-svd(((n-1)/n)*var(X))
sigmainvsqrt<-res$u%*%diag(1/sqrt(res$d))%*%t(res$v)
centre<-apply(X,2,mean)
Xcentre<-sweep(X,2,centre)
Xstd<-Xcentre%*%sigmainvsqrt

matXY<-cbind(Y,X) 
Xord<-matXY[sort.list(matXY[,1]),-1] #sort X by Y

M1<-matrix(0,ncol=p,nrow=p)
M2<-matrix(0,ncol=p,nrow=p)
Msave<-matrix(0,ncol=p,nrow=p)


Vbar<-matrix(0,ncol=p,nrow=p)

for(h in 1:H){
Vh<-((nbind[h]-1)/nbind[h])*var(Xord[rep(1:H,nbind)==h,])
Vbar<-Vbar+(nbind[h]/n)*Vh
}

for(h in 1:H){
moyh<-matrix(apply(Xord[rep(1:H,nbind)==h,],2,mean),ncol=1)
M1<-M1+(nbind[h]/n)*moyh%*%t(moyh)
M2<-M2+(nbind[h]/n)*(sigmainvsqrt%*%(Vh-Vbar)%*%sigmainvsqrt)%*%t(sigmainvsqrt%*%(Vh-Vbar)%*%sigmainvsqrt)
Msave<-Msave+(nbind[h]/n)*(diag(p)-sigmainvsqrt%*%Vh%*%sigmainvsqrt)%*%t(diag(p)-sigmainvsqrt%*%Vh%*%sigmainvsqrt)
}

M1<-M1-moyX%*%t(moyX)
M1<-sigmainvsqrt%*%M1%*%sigmainvsqrt

M<-switch(method,
 "SIR-I"= M1,
 "SIR-II"= M2,
 "SAVE"= Msave)

rSIR<-eigen(M)
matEDR <- as.matrix(sigmainvsqrt %*% rSIR$vectors)

res <- list(matEDR = matEDR, eigvalEDR = rSIR$values, K=K, H=H, n=n, method=method, X=X, Y=Y)
class(res) <-"edr"  
res
}

