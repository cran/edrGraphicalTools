\name{criterionRkh}
\alias{criterionRkh}
\title{
Estimation of the Rkh criterion by bootstrap method
}
\description{
This is the main function in the edrGraphicalTools package. This function estimates the square trace correlation criterion Rkh by bootstrap in order 
to simultaneously choose the number H of slices and the dimension K of the EDR space reduction.
It creates objects of class \code{criterionRkh}. Several helper functions that require a \code{criterionRkh} object can then be applied to the output from this function. 
}

\usage{
criterionRkh(Y, X, H, K, indices, B = 50, method)
}



\arguments{
  \item{Y}{
A numeric vector representing the dependent variable (a response vector). 
}
  \item{X}{
A matrix representing the quantitative explanatory variables (bind by column). 
}
  \item{H}{
An integer vector representing the different number of slices to be investigated. By default H takes integer values in \code{2,3,...,round(n/4)}; \code{n} is the sample size.   
}
  \item{K}{
An integer vector representing the different dimension K to be investigated. By default K takes integer values in \code{1,2,...,min(p,25)}; \code{p} is the number of explanatory variables. 
}
  \item{indices}{
An optional integer  vector specifying the indices of the bootstrap samples. By default, non-paramatric resampling is performed. 
If used, an integer vector of length \code{B}*\code{n} will be specified; (\code{n} is the length of \code{Y}).
}
  \item{B}{
The number of bootstrap replicates. By default \code{B} equals 50.
}
  \item{method}{
This character string specifies the method of fitting. The options include "SIR-I", "SIR-II", and "SAVE". 
}
}


\details{
We are interested in the following semiparametric dimension reduction model proposed by Li (1991)
\deqn{y=f(b1'x,b2'x,...,bK'x,e)}
where the univariate response variable \eqn{y} is associated with the p-dimensional regressor
\eqn{p} only through the reduced K-dimensional variable \eqn{(b1'x,b2'x,...,bK'x)}
 with \eqn{K < p}. The error term \eqn{e} is independent of \eqn{x}. The link function \eqn{f} and the \eqn{b}-vectors are unknown. We are
interested in finding the linear subspace spanned by the \eqn{K} unknown \eqn{b}-vector, called the effective dimension reduction (EDR) space.
We focus on the SIR (named SIR-I), SIR-II and SAVE methods to estimate the EDR space. The slicing step of these methods depends on the number \eqn{H}  of slices.
We propose a naive bootstrap estimation of the square trace correlation criterion to allow selection of an ``optimal'' number
of slices and to simultaneously select the corresponding suitable dimension \eqn{K} (number of the linear combinations of \eqn{x}).
}
\value{
\code{criterionRkh} returns an object of class criterionRkh (the name of the type is the
value of the \code{method} argument), with attributes:
  \item{Rkhbootmean}{A matrix corresponding of the estimation by bootstrap of the square trace criterion Rkh (h in rows and k in columns).}
  \item{Rkhboot}{A list including the result of the estimation of the square trace criterion for each bootsrap replicate.}
  \item{method}{the dimension reduction method used.} 
  \item{n}{Number of subject.}
  \item{H}{A vector representing the different numbers H of slices investigated.}
  \item{K}{A vector representing the different dimensions K investigated.}
  \item{indices}{An vector of integers representing the indices of the bootstrap sample used.}
}



\references{	
Liquet, B. and Saracco, J. (2012). A graphical tool for selecting the number of slices and the dimension of the model in SIR and SAVE approaches. \emph{Computational Statistics}, 27(1), 103-125.

Li, K.C. (1991). Sliced inverse regression for dimension reduction, with discussions.
\emph{Journal of the American Statistical Association} 86, 316-342.

Cook, R. D. and Weisberg, S. (1991). Discussion of ``Sliced inverse regression''. \emph{Journal of the American
Statistical Association}, 86, 328-332.

}

\author{Benoît Liquet, <benoit.liquet@isped.u-bordeaux2.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}

%\note{}

\seealso{
\code{\link{edr}}, \code{\link{summary.criterionRkh}}, \code{\link{plot.criterionRkh}}
}

\examples{
## simulated example 1 
set.seed(10)
n <- 500
beta <- c(1,rep(0,9))
X <- rmvnorm(n,sigma=diag(10))
eps <- rnorm(n)
Y <- (X\%*\%beta)**3+eps*((X\%*\%beta)**2)
## Choice a grid of values for H
grid.H <- c(2,5,10,15,20,30)
res1 <- criterionRkh(Y,X,H=grid.H,B=50,method="SIR-I")
res1
#plot(res1,choice.H=c(2,5),choice.K=c(1,2))
## Estimation for SIR-II method with the same bootstrap replicate than for SIR-I
res2 <- criterionRkh(Y,X,H=grid.H,indices=res1$indices,B=50,method="SIR-II")
res2

}
\keyword{regression }
