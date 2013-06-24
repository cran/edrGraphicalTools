pkgname <- "edrGraphicalTools"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('edrGraphicalTools')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("criterionRkh")
### * criterionRkh

flush(stderr()); flush(stdout())

### Name: criterionRkh
### Title: Estimation of the Rkh criterion by bootstrap method
### Aliases: criterionRkh
### Keywords: regression

### ** Examples

## simulated example 1 
set.seed(10)
n <- 500
beta <- c(1,rep(0,9))
X <- rmvnorm(n,sigma=diag(10))
eps <- rnorm(n)
Y <- (X%*%beta)**3+eps*((X%*%beta)**2)
## Choice a grid of values for H
grid.H <- c(2,5,10,15,20,30)
res1 <- criterionRkh(Y,X,H=grid.H,B=50,method="SIR-I")
res1
plot(res1,choice.H=c(2,5),choice.K=c(1,2))
## Estimation for SIR-II method with the same bootstrap replicate than for SIR-I
res2 <- criterionRkh(Y,X,H=grid.H,indices=res1$indices,B=50,method="SIR-II")
res2




cleanEx()
nameEx("edr")
### * edr

flush(stderr()); flush(stdout())

### Name: edr
### Title: Main function for estimation of the e.d.r space
### Aliases: edr
### Keywords: regression

### ** Examples

set.seed(10)
n <- 500
beta1 <- c(1,1,rep(0,8))
beta2 <- c(0,0,1,1,rep(0,6))
X <- rmvnorm(n,sigma=diag(1,10))
eps <- rnorm(n)
Y <- (X%*%beta1)**2+(X%*%beta2)**2+eps

## Estimation of the trace square criterion 
## grid.H <- c(2,5,10,15,20,30)
## res2 <- criterionRkh(Y,X,H=grid.H,B=50,method="SIR-II")
## summary(res2)
## plot(res2)

## Estimation of the e.d.r direction for K=2 and H=2 and SIR-II method
edr2 <- edr(Y,X,H=2,K=2,method="SIR-II")
summary(edr2)
plot(edr2)



cleanEx()
nameEx("edrGraphicalTools-package")
### * edrGraphicalTools-package

flush(stderr()); flush(stdout())

### Name: edrGraphicalTools-package
### Title: Provide graphical tools for dimension reduction methods
### Aliases: edrGraphicalTools-package edrGraphicalTools
### Keywords: package

### ** Examples

## plot example 1
set.seed(10)
n <- 500
beta <- c(1,rep(0,9))
X <- rmvnorm(n,sigma=diag(10))
eps <- rnorm(n)
Y <- (X%*%beta)**3+eps*((X%*%beta)**2)
## Choice a grid of integer values for H
grid.H <- c(2,5,10,15,20)
res1 <- criterionRkh(Y,X,H=grid.H,K=c(1:10),B=50,method="SIR-I")
plot(res1,choice.H=c(2,5),choice.K=c(1,2))



cleanEx()
nameEx("edrUnderdet")
### * edrUnderdet

flush(stderr()); flush(stdout())

### Name: edrUnderdet
### Title: E.d.r. space estimation for underdetermined cases.
### Aliases: edrUnderdet
### Keywords: nonlinear

### ** Examples


n <- 100
p <- 200
K <- 2
H <- 3:8
beta1 <- c(1,1,1,1,rep(0,p-4))
beta2 <- c(rep(0,p-4), 1,1,1,1)
X <- rmvnorm(n,sigma=diag(p))
eps <- rnorm(n,sd=10)
Y <- (X%*%beta1)^3 + (X%*%beta2)^3+eps
result <- edrUnderdet(Y,X,H,K,"SIR-QZ")
summary(result)
plot(result)




cleanEx()
nameEx("plot.criterionRkh")
### * plot.criterionRkh

flush(stderr()); flush(stdout())

### Name: plot.criterionRkh
### Title: Graphical tools for the bootstrap criterion
### Aliases: plot.criterionRkh
### Keywords: regression

### ** Examples

## see example in function criterionRkh



cleanEx()
nameEx("plot.edr")
### * plot.edr

flush(stderr()); flush(stdout())

### Name: plot.edr
### Title: Basic plot of a edr object
### Aliases: plot.edr
### Keywords: regression

### ** Examples

## simulated example 
set.seed(10)
n <- 500
beta1 <- c(1,1,rep(0,8))
beta2 <- c(0,0,1,1,rep(0,6))
X <- rmvnorm(n,sigma=diag(1,10))
eps <- rnorm(n)
Y <- (X%*%beta1)**2+(X%*%beta2)**2+eps
edr2 <- edr(Y,X,H=2,K=2,method="SIR-II")
plot(edr2)
## edr4 <- edr(Y,X,H=2,K=4,method="SIR-II")
## plot(edr4)





cleanEx()
nameEx("sliceMat")
### * sliceMat

flush(stderr()); flush(stdout())

### Name: sliceMat
### Title: Slicing matrix computation
### Aliases: sliceMat
### Keywords: nonlinear

### ** Examples
 

#The "SIR-I" method whithout using 'edr'
n <- 500
p <- 5
H <- 10
beta <- c(1, 1, 1, 0, 0)
X <- rmvnorm(n,rep(0,p),diag(p))
eps <- rnorm(n, 0, 10)
Y <- (X %*% beta)^3 + eps
M <- sliceMat(Y,X,H)
hatBeta <- eigen(solve(var(X)) %*% M)$vectors[,1]
cor(hatBeta,beta)^2
 


### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
