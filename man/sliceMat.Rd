\name{sliceMat}
\alias{sliceMat}

\title{
Slicing matrix computation
}
\description{
Returns the slicing matrix required for the "SIR-I" method.
}
\usage{
sliceMat(Y, X, H, details=FALSE, rdSup=FALSE)
}

\arguments{
  \item{Y}{
A numeric vector representing the dependent variable (a response vector). 
}
  \item{X}{
A matrix representing the quantitative explanatory variables (bind by column). 
}

 \item{H}{The chosen number of slices.}

 \item{details}{A boolean that determines whether or not some matrices used to construct the slicing matrix should be sent back. See also 'Value'.}

 \item{rdSup}{When the number of slices is not a divisor of the sample size, this boolean determines whether or not the slices which contain an extra point are randomly chosen.}  
 
}
\details{This function divides the range of \eqn{Y} in \eqn{H} distinct intervals, or slices. 
It then puts every row of \eqn{X} into a slice with respect to the corresponding element of \eqn{Y}. 
It finally computes a matrix \eqn{M = X_h' P_h X_h} where each row of \eqn{X_h} is 
the mean vector over the vectors of \eqn{X} that belong to a given slice.
The matrix \eqn{P_h} is diagonal and contains the number of rows of \eqn{X} 
placed in each sliced.
The matrix \eqn{M} is required when trying to perform a sliced inverse regression.
}
                  
\value{
If \code{details=FALSE}, the \eqn{p} x \eqn{p} slicing matrix \eqn{M}, where \eqn{p} is the number of columns of \eqn{X}.

If \code{details=TRUE}, a list made of \eqn{M}, \eqn{X_h} and \eqn{P_h}.

}


\author{Raphaël Coudret <rcoudret@gmail.com>, Benoît Liquet <benoit.liquet@isped.u-bordeaux2.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}

\seealso{\code{\link{edr}}, \code{\link{edrUnderdet}}}



\examples{ 

#The "SIR-I" method whithout using 'edr'
n <- 500
p <- 5
H <- 10
beta <- c(1, 1, 1, 0, 0)
X <- rmvnorm(n,rep(0,p),diag(p))
eps <- rnorm(n, 0, 10)
Y <- (X \%*\% beta)^3 + eps
M <- sliceMat(Y,X,H)
hatBeta <- eigen(solve(var(X)) \%*\% M)$vectors[,1]
cor(hatBeta,beta)^2
 }

\keyword{nonlinear}
