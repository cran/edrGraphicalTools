\name{edrGraphicalTools-package}
\alias{edrGraphicalTools-package}
\alias{edrGraphicalTools}
\docType{package}
\title{
Provide graphical tools for dimension reduction methods
}
\description{
This package comes to illustrate the article
``A graphical tool for selecting the number of slices and
 the dimension of the model in SIR and SAVE approaches''.
 It estimate by bootstrap a square trace correlation criterion which measures the quality of the
 estimation of the effective dimension reduction (e.d.r) space. 
}
\details{
\tabular{ll}{
Package: \tab edrGraphicalTools\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2010-04-14\cr
License: \tab GPL (>=2.0)\cr
LazyLoad: \tab yes\cr
}
}
\author{
 <benoit.liquet@isped.u-bordeaux2.fr>, <jerome.saracco@math.u-bordeaux1.fr>}
 
\references{
Liquet B. and Saracco, J., A graphical tool for selecting the number of
slices and the dimension of the model in SIR and SAVE approaches \emph{Revised paper}.
}

\keyword{ package }
\seealso{
\code{\link{criterionRkh}}, \code{\link{edr}}, \code{\link{plot.criterionRkh}}
}
\examples{
## plot example 1
set.seed(10)
n <- 500
beta <- c(1,rep(0,9))
X <- rmvnorm(n,sigma=diag(10))
eps <- rnorm(n)
Y <- (X\%*\%beta)**3+eps*((X\%*\%beta)**2)
## Choice a grid of integer values for H
grid.H <- c(2,5,10,15,20)
res1 <- criterionRkh(Y,X,H=grid.H,K=c(1:10),B=50,method="SIR-I")
plot(res1,choice.H=c(2,5),choice.K=c(1,2))
}
