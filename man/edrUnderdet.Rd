\name{edrUnderdet}
\alias{edrUnderdet}

\title{
EDR space estimation for underdetermined cases.
}
\description{
Gathers several procedures to estimate the effective dimension regression (EDR) space when the number of explanatory variables is greater than the sample size.
Creates an object of class \code{edr}. 
}
\usage{
edrUnderdet(Y, X, H, K, method, initEDR=NULL, maxIter=NULL, 
regulParam=NULL, sMin=1e-16, sChg=10, btspSamp=NULL)
}

\arguments{
\item{Y}{
A numeric vector representing the dependent variable (a response vector). 
}
  \item{X}{
A matrix representing the quantitative explanatory variables (bind by column). 
}

 \item{H}{When \code{method="SR-SIR"} or \code{method="RSIR"}, the chosen number of slices. When \code{method="SIR-QZ"}, a vector with various numbers of slices.}

 \item{K}{The chosen dimension K.}
  
  
  
  \item{method}{
This character string specifies the method of fitting. It should be either "SIR-QZ", "RSIR" or "SR-SIR".
}

	\item{initEDR}{
	When \code{method="SR-SIR"}, a \eqn{p} x \eqn{K} matrix which contains initial values for the iterative algorithm that estimates EDR directions.
}

	\item{maxIter}{
	When \code{method="SR-SIR"}, a maximum number of iterations after which the algorithm stops.
}

	\item{regulParam}{
	When \code{method="SR-SIR"} or \code{method="RSIR"}, a vector containing possible values of the regularization parameter, from which the optimal one will be chosen.
}

	\item{sMin}{
	When \code{method="SIR-QZ"}, the smallest regularization parameter to test.
}

	\item{sChg}{
	When \code{method="SIR-QZ"}, a positive real by which a regularization parameter is multiplied to produce the next one to consider.
}

	\item{btspSamp}{
	When \code{method="RSIR"}, the bootstrap sample size for estimating the mean squared error.
}

}
\details{
 The "SIR-QZ" method estimates the indices rather than the EDR directions. It makes use of several estimations from several numbers of slices. It tries to find a minimal regularization of the covariance matrix of \eqn{X}. 
The "RSIR" procedure uses a bootstrap estimator of the mean squared error of regularized estimates of the EDR directions.
It was translated from a Matlab code made by Peng Zeng.
The "SR-SIR" procedure relies on a generalized cross-validation criterion and on an alternating least squares algorithm to find an optimal regularization parameter.
It was written using a R code made by Lexin Li. See also \url{http://www4.stat.ncsu.edu/~li/software.html}.
}
                  
\value{
\code{edrUnderdet} returns an object of class \code{edr}, with some of the 
following attributes, depending on the value  of \code{method}:
  \item{matEDR}{A matrix spanning the estimated EDR space.}
	\item{indices}{The estimated indices from the "SIR-QZ" method.}
  \item{eigvalEDR}{The eigenvalues of a matrix of interest.}
  \item{K}{The chosen dimension.}
  \item{H}{The chosen number(s) of slices.}
  \item{n}{The sample size.}
  \item{method}{The dimension reduction method used.} 
   \item{X}{The matrix of the quantitative explanatory variables (bind by column).}
  \item{Y}{The numeric vector of the dependent variable (a response vector).}
	\item{s}{The optimal regularization parameter(s) found by the chosen method.} 
	\item{estMSE}{For each tested regularization parameter, the estimated mean squared error from the "RSIR" method.}  
	\item{testedEDR}{For each tested regularization parameter, a matrix spanning the estimated EDR space from the "SR-SIR" method.}  
	\item{iter}{For each tested regularization parameter, the number of iterations needed for the alternating least squares algorithm from the "SR-SIR" method to converge.}
	\item{gcv}{For each tested regularization parameter, the corresponding generalized cross-validation criterion from the "SR-SIR" method.}
}



\references{
Coudret, R., Liquet, B. and Saracco, J. Comparison of sliced inverse regression approaches for underdetermined cases. \emph{Journal de la Société Française de Statistique}, in press.

Li, L. and Yin, X. (2008). Sliced inverse regression with regularizations. \emph{Biometrics}, 64(1):124-131.

Zhong, W., Zeng, P., Ma, P., Liu, J. S., and Zhu, Y. (2005). RSIR: regularized
sliced inverse regression for motif discovery. \emph{Bioinformatics}, 21(22):4169-4175.

}

\author{Raphaël Coudret <rcoudret@gmail.com>, Benoît Liquet <benoit.liquet@isped.u-bordeaux2.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}

%\note{}

\seealso{
\code{\link{edr}},  \code{\link{sliceMat}}
}


\examples{

n <- 100
p <- 200
K <- 2
H <- 3:8
beta1 <- c(1,1,1,1,rep(0,p-4))
beta2 <- c(rep(0,p-4), 1,1,1,1)
X <- rmvnorm(n,sigma=diag(p))
eps <- rnorm(n,sd=10)
Y <- (X\%*\%beta1)^3 + (X\%*\%beta2)^3+eps
result <- edrUnderdet(Y,X,H,K,"SIR-QZ")
summary(result)
plot(result)

}

\keyword{ nonlinear }
