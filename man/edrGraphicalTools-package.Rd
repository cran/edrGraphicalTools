\name{edrGraphicalTools-package}
\alias{edrGraphicalTools-package}
\alias{edrGraphicalTools}
\docType{package}
\title{
Provides graphical tools for dimension reduction methods
}
\description{
This package illustrates the articles listed below.
It estimates by bootstrap a squared trace correlation criterion which measures 
the quality of the estimation of the effective dimension reduction (EDR) space.
It also contains functions to perform such an estimation when the sample size 
is smaller than the number of explanatory variables. 
Methods to select the relevant explanatory variables are also included.
}
\details{
\tabular{ll}{
Package: \tab edrGraphicalTools\cr
Type: \tab Package\cr
Version: \tab 2.0\cr
Date: \tab 2013-06-21\cr
License: \tab GPL (>=2.0)\cr
LazyLoad: \tab yes\cr
}
}
\author{Raphaël Coudret <rcoudret@gmail.com>, Benoît Liquet <benoit.liquet@isped.u-bordeaux2.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}
 
\references{
Liquet, B. and Saracco, J. (2012). A graphical tool for selecting the number of slices and the dimension of the model in SIR and SAVE approaches. \emph{Computational Statistics}, 27(1), 103-125.

Coudret, R., Liquet, B. and Saracco, J. Comparison of sliced inverse regression approaches for underdetermined cases. \emph{Journal de la Société Française de Statistique}, in press.
}

\keyword{ package }
\seealso{
\code{\link{criterionRkh}}, \code{\link{edr}}, \code{\link{plot.criterionRkh}},
\code{\link{edrSelec}}, \code{\link{edrUnderdet}}
}
\examples{
## Sample generation
set.seed(10)
n <- 500
p <- 10
beta <- c(1,rep(0,p-1))
X <- rmvnorm(n,sigma=diag(p))
eps <- rnorm(n)
Y <- (X\%*\%beta)**3+eps*((X\%*\%beta)**2)

## Determining optimal values for H and K
grid.H <- c(2,5,10,15,20)
grid.K <- 1:p
res1 <- criterionRkh(Y,X,H=grid.H,K=grid.K,B=50,method="SIR-I")
#plot(res1,choice.H=c(2,5),choice.K=c(1,2))
HK <- which(res1$Rkhbootmean[,1:(p-1)] == max(res1$Rkhbootmean[,1:(p-1)]),
	arr.ind=TRUE)[1,]
H  <- grid.H[HK[1]]
K <- grid.K[HK[2]]

## Selecting relevant variables in X
if (K==1) \{
	res2 <- edrSelec(Y, X, H, K, "CSS", pZero=p/2, NZero=200, zeta=0.05)
	dev.new()
	plot(res2)
	if (1 \%in\% which(res2$scoreVar == max(res2$scoreVar))) \{
		message("The first variable is selected, as it should be.")
	\} else \{
		message("The variable selection failed.")
	\} 
\} else \{
	message("The choice of K failed.")
\}


}
