\name{plot.criterionRkh}
\alias{plot.criterionRkh}
\title{
Graphical tools for the bootstrap criterion
}
\description{
We propose a 3D-graphical tool which can be useful to select the suitable couple (H,K).
We also add some boxplots of the distribution of the bootstrap criterion. 
}

\usage{
\method{plot}{criterionRkh}(x, choice.H, choice.K, \dots)
}

\arguments{
  \item{x}{
The name of an object of class \code{\link{criterionRkh}}. 
}
  \item{choice.H}{
An optional integer vector specifing the values of H for which a boxplot of the distribution of the bootstrap criterion is plotted for all the values
of K specified in the \code{criterionRkh} object. The values of \code{choice.H} must be included in the values of H specified in the \code{criterionRkh} object.
}
  \item{choice.K}{
An optional integer vector specifing the values of K for which a boxplot of the distribution of the bootstrap criterion is plotted for all the values
of H specified in the \code{criterionRkh} object. The values of \code{choice.K} must be included in the values of K specified in the \code{criterionRkh} object.
}

 \item{\dots}{Some methods for this generic require additional arguments. None are used in this method. }
}

\value{
Returns  graphs.
}
\references{
Liquet B. and Saracco, J., A graphical tool for selecting the number of
slices and the dimension of the model in SIR and SAVE approaches. \emph{Revised paper}
}
\author{
Benoit Liquet, <benoit.liquet@isped.u-bordeaux2.fr> and Jerome Saracco <jerome.saracco@math.u-bordeaux1.fr>
}


\seealso{
 \code{\link{criterionRkh}}
}
\examples{
## see example in function criterionRkh
}

\keyword{ regression }
