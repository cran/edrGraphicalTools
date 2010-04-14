\name{edr}
\alias{edr}

\title{
Main function for estimation of the e.d.r space
}
\description{
It creates objects of class edr to estimate the effective dimension regression (e.d.r) space. Several helper functions that require a edr object can then be applied to the output from this function. 
}
\usage{
edr(Y, X, H, K, method)
}

\arguments{
  \item{Y}{
A numeric vector representing the dependent variable (a response vector). 
}
  \item{X}{
A matrix representing the quantitative explanatory variables (bind by column). 
}

 \item{H}{The chosen number of slices.}

 \item{K}{The chosen dimension K.}
  
  
  
  \item{method}{
This character string specifies the method of fitting. The option includes "SIR-I", "SIR-II", and "SAVE". 
}
}
\details{
We interested in the following semiparametric dimension reduction model proposed by Li (1991)
\deqn{y=f(b1'x,b2'x,...,bK'x,e)}
where the univariate response variable \eqn{y} is associated with the p-dimensional regressor
\eqn{p} only through the reduced \eqn{K}-dimensional variable \eqn{(b1'x,b2'x,...,bK'x)}
 with \eqn{K < p}. The error term \eqn{e} is independent of \eqn{x}. The link function \eqn{f} and the \eqn{b}-vectors are unknown. We are
interested in finding the linear subspace spanned by the \eqn{K} unknown \eqn{b}-vector, called the effective dimension reduction (e.d.r.) space.
We focus on the SIR, SIR-II and SAVE methods to estimate the e.d.r space. The slicing step of these methods depends on the number \eqn{H} of slices.
We propose with the function \code{\link{criterionRkh}} a naive bootstrap estimation of the square trace correlation criterion to allow selection of an ``optimal'' number
H of slices and simultaneously the corresponding suitable dimension \eqn{K} (number of the linear combination of \eqn{x}).
After choosing an optimal couple \eqn{(H,K)} for the best estimation method  (the square trace correlation criterion closest to one), the e.d.r space could be estimate
with this function. Each method consists in a spectral decomposition of a matrix of interest. The eigenvectors of this matrix associated
of the K largest eigenvalues are e.d.r directions. 
}
                  
\value{
\code{edr} returns an object that inherits from edr, with attributes:
  \item{matEDR}{A matrix corresponding of the eigenvectors of the interest matrix}
  \item{eigvalEDR}{The eigenvalues of the matrix of interest}
  \item{K}{The chosen dimension.}
  \item{H}{The chosen number of slices.}
  \item{n}{Sample size.}
  \item{method}{The dimension reduction method used.} 
   \item{X}{The matrix of the quantitative explanatories variables (bind by column).}
   \item{Y}{The numeric vector of the dependent variable (a response vector).}
  
}



\references{
Liquet B. and Saracco, J., A graphical tool for selecting the number of
slices and the dimension of the model in SIR and SAVE approaches. \emph{Revised paper}.

Li, K.C. (1991). Sliced inverse regression for dimension reduction, with discussions.
\emph{Journal of the American Statistical Association} 86, 316-342.

Cook, R. D. and Weisberg, S. (1991). Discussion of ``Sliced inverse regression''. \emph{Journal of the American
Statistical Association}, 86, 328-332.
}

\author{Benoit Liquet, <benoit.liquet@isped.u-bordeaux2.fr> and Jerome Saracco <jerome.saracco@math.u-bordeaux1.fr>}

%\note{}

\seealso{
\code{\link{criterionRkh}},  \code{\link{summary.edr}}, \code{\link{plot.edr}}
}


\examples{
set.seed(10)
n <- 500
beta1 <- c(1,1,rep(0,8))
beta2 <- c(0,0,1,1,rep(0,6))
X <- rmvnorm(n,sigma=diag(1,10))
eps <- rnorm(n)
Y <- (X\%*\%beta1)**2+(X\%*\%beta2)**2+eps

## Estimation of the trace square criterion 
## grid.H <- c(2,5,10,15,20,30)
## res2 <- criterionRkh(Y,X,H=grid.H,B=50,method="SIR-II")
## summary(res2)
## plot(res2)

## Estimation of the e.d.r direction for K=2 and H=2 and SIR-II method
edr2 <- edr(Y,X,H=2,K=2,method="SIR-II")
summary(edr2)
plot(edr2)
}

\keyword{ regression }
