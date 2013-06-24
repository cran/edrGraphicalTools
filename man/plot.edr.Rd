\name{plot.edr}
\alias{plot.edr}

\title{
Basic plot of an edr object
}
\description{
For an \code{edr} object with attributes \code{K} <= 2, this function plots the response y versus each 
new estimate indice with an estimation of the link function. For \code{K} = 2, a 3D plot of y versus the two estimate indices
is represented. A smooth estimate of the link function is also represented. For \code{K} > 2, the \code{pairs} function is used.}

\usage{
\method{plot}{edr}(x, \dots)
}
\arguments{
  \item{x}{
The name of an object of class \code{\link{edr}}.
}
 \item{\dots}{Some methods for this generic require additional arguments. None are used in this method. }
}


\value{
Returns graphs.
}

\author{Benoît Liquet, <benoit.liquet@isped.u-bordeaux2.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}


\seealso{
\code{\link{summary.edr}}
}
\examples{
## simulated example 
set.seed(10)
n <- 500
beta1 <- c(1,1,rep(0,8))
beta2 <- c(0,0,1,1,rep(0,6))
X <- rmvnorm(n,sigma=diag(1,10))
eps <- rnorm(n)
Y <- (X\%*\%beta1)**2+(X\%*\%beta2)**2+eps
edr2 <- edr(Y,X,H=2,K=2,method="SIR-II")
plot(edr2)
## edr4 <- edr(Y,X,H=2,K=4,method="SIR-II")
## plot(edr4)


}
\keyword{ regression }
