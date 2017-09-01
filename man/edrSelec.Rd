\name{edrSelec}
\alias{edrSelec}

\title{
Variable selection based on sliced inverse regression
}
\description{
Gathers several procedures to determine which explanatory variables have an effect
on a dependent variable. 
Works whether there are more explanatory variables than observations or not.
Creates an object of class \code{edrSelec}.
}
\usage{
edrSelec(Y, X, H, K, method, pZero=NULL, NZero=NULL, zeta=NULL,
 rho=NULL, baseEst=NULL, btspSamp=NULL, lassoParam=NULL)
}

\arguments{
\item{Y}{
A numeric vector representing the dependent variable (a response vector). 
}
  \item{X}{
A matrix representing the quantitative explanatory variables (bind by column). 
}

 \item{H}{When \code{method="SR-SIR"} or \code{method="RSIR"}, the chosen number of slices. When \code{method="CSS"}, a vector with various numbers of slices.}

 \item{K}{The chosen dimension K.}
  
  
  
  \item{method}{
This character string specifies the selection method. It should be either "CSS", "RSIR" or "SR-SIR".
}

	\item{pZero}{
	When \code{method="CSS"}, the number of variables to pick when creating a submodel.
}

	\item{NZero}{
	When \code{method="CSS"}, the number of submodels to create.
}

	\item{zeta}{
	When \code{method="CSS"}, the proportion of 'best' submodels selected from the \code{NZero} submodels.
}

	\item{rho}{
	When \code{method="CSS"}, and if \code{zeta} is not provided, the threshold above which a submodel is considered as 'best'. It must be a real in ]0,1[.
}

	\item{baseEst}{
	An initial estimate of the EDR space on which each method relies. 
}

	\item{btspSamp}{
	When \code{method="RSIR"}, the bootstrap sample size for estimating the asymptotic distribution of the estimated EDR directions.
}

	\item{lassoParam}{
	When \code{method="SR-SIR"}, a vector of lasso parameters from which the optimal one is chosen, using the RIC criterion.
}

}
\details{
The "CSS" method builds \code{NZero} submodels using only \code{pZero} explanatory variables. 
It estimates the indices for each of them. 
The squared correlation between these indices and those found with the whole set of explanatory variables is computed.
Only the submodels with the highest squared correlation are kept.
The method then counts how many times each explanatory variable appears in these
'best' submodels.
The "RSIR" procedure uses an asymptotic test on each element of the estimated 
EDR directions. 
It was translated from a Matlab code made by Peng Zeng.
The "SR-SIR" procedure relies on a lasso penalty. The underlying parameter is chosen using the residual information criterion (RIC).
It was written using a R code made by Lexin Li. 
}
                  
\value{
\code{edrSelec} returns an object of class \code{edrSelec}, with some of the 
following attributes, depending on the value  of \code{method}:
  \item{scoreVar}{A numeric vector filled with a score for each explanatory variable. Variables that have a high score should be kept. For the "CSS" method, the score is the presence of the variable in the 'best' submodels. For "RSIR", it is one minus the p-value of the test. For the "SR-SIR" procedure, it is a boolean that indicates if the variable should be kept when using the optimal lasso parameter.}
	\item{K}{The chosen dimension.}
  \item{H}{The chosen number(s) of slices.}
  \item{n}{The sample size.}
  \item{method}{The variable selection method used.} 
   \item{X}{The matrix of the quantitative explanatory variables (bind by column).}
  \item{Y}{The numeric vector of the dependent variable (a response vector).}
	\item{matModels}{A \code{NZero} x \code{pZero} matrix that contains the variables of each created submodel, for the "CSS" method.}
	\item{matModTop}{A matrix with \code{pZero} columns made of the variables of each 'best' submodel, for the "CSS" method.}
	\item{vectSqCor}{A vector containing the squared correlation between indices for each submodel, for the "CSS" method.}
	\item{aic}{A vector made of values of the Akaïke information criterion for every lasso parameter considered by the "SR-SIR" procedure.}
	\item{bic}{A vector made of values of the Bayesian information criterion for every lasso parameter considered by the "SR-SIR" procedure.}
	\item{ric}{A vector made of values of the residual information criterion for every lasso parameter considered by the "SR-SIR" procedure.}
	\item{matEDR}{A list which gives, for each lasso parameter studied with the "SR-SIR" procedure, a matrix spanning the estimated EDR space. }
}



\references{
Coudret, R., Liquet, B. and Saracco, J. Comparison of sliced inverse regression approaches for underdetermined cases. \emph{Journal de la Société Française de Statistique}, in press.

Li, L. and Yin, X. (2008). Sliced inverse regression with regularizations. \emph{Biometrics}, 64(1):124-131.

Zhong, W., Zeng, P., Ma, P., Liu, J. S., and Zhu, Y. (2005). RSIR: regularized
sliced inverse regression for motif discovery. \emph{Bioinformatics}, 21(22):4169-4175.

}

\author{Raphaël Coudret <rcoudret@gmail.com>, Benoît Liquet <benoit.liquet@univ-pau.fr> and Jérôme Saracco <jerome.saracco@math.u-bordeaux1.fr>}

%\note{}

\seealso{
\code{\link{edr}},  \code{\link{edrUnderdet}}
}


\examples{
	\dontrun{
n <- 100
p <- 110
K <- 1
H <- 5:12
NZero <- 1000
pZero <- 10
zeta <- 0.1
beta <- c(1,1,1,1,rep(0,p-4))
U <- matrix(runif(p^2,-0.05,0.05),ncol=p) 
X <- rmvnorm(n,sigma=diag(p) + U \%*\% t(U))
eps <- rnorm(n,sd=10)
Y <- (X\%*\%beta)^3+eps
result <- edrSelec(Y,X,H,K,"CSS",NZero=NZero, pZero=pZero, zeta=zeta)
summary(result)
plot(result)}

}

\keyword{ nonlinear }
