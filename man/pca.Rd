\name{pca}
\alias{pca}
\title{Perform principal component analysis}
\usage{
  pca(object, method, nPcs = 2,
    scale = c("none", "pareto", "vector", "uv"),
    center = TRUE, completeObs = TRUE, subset = NULL,
    cv = c("none", "q2"), ...)
}
\arguments{
  \item{object}{Numerical matrix with (or an object
  coercible to such) with samples in rows and variables as
  columns. Also takes \code{ExpressionSet} in which case
  the transposed expression matrix is used. Can also be a
  data frame in which case all numberic variables are used
  to fit the PCA.}

  \item{method}{One of the methods reported by
  \code{listPcaMethods()}. Can be left missing in which
  case the \code{svd} PCA is chosen for data wihout missing
  values and \code{nipalsPca} for data with missing values}

  \item{nPcs}{Number of principal components to calculate.}

  \item{scale}{Scaling, see \code{\link{prep}}.}

  \item{center}{Centering, see \code{\link{prep}}.}

  \item{completeObs}{Sets the \code{completeObs} slot on
  the resulting \code{pcaRes} object containing the
  original data with but with all NAs replaced with the
  estimates.}

  \item{subset}{A subset of variables to use for
  calculating the model. Can be column names or indices.}

  \item{cv}{character naming a the type of cross-validation
  to be performed.}

  \item{...}{Arguments to \code{\link{prep}}, the chosen
  pca method and \code{\link{Q2}}.}
}
\value{
  A \code{pcaRes} object.
}
\description{
  Perform PCA on a numeric matrix for visualisation,
  information extraction and missing value imputation.
}
\details{
  This method is wrapper function for the following set of
  pca methods:

  \describe{\item{svd:}{Uses classical \code{prcomp}. See
  documentation for \code{\link{svdPca}}.}

  \item{nipals:}{An iterative method capable of handling
  small amounts of missing values. See documentation for
  \code{\link{nipalsPca}}.}

  \item{rnipals:}{Same as nipals but implemented in R.}

  \item{bpca:}{An iterative method using a Bayesian model
  to handle missing values. See documentation for
  \code{\link{bpca}}.}

  \item{ppca:}{An iterative method using a probabilistic
  model to handle missing values. See documentation for
  \code{\link{ppca}}.}

  \item{svdImpute:}{Uses expectation maximation to perform
  SVD PCA on incomplete data. See documentation for
  \code{\link{svdImpute}}.}}

  Scaling and centering is part of the PCA model and
  handled by \code{\link{prep}}.
}
\examples{
data(iris)
##  Usually some kind of scaling is appropriate
pcIr <- pca(iris, method="svd", nPcs=2)
pcIr <- pca(iris, method="nipals", nPcs=3, cv="q2")
## Get a short summary on the calculated model
summary(pcIr)
plot(pcIr)
## Scores and loadings plot
slplot(pcIr, sl=as.character(iris[,5]))
}
\author{
  Wolfram Stacklies, Henning Redestig
}
\references{
  Wold, H. (1966) Estimation of principal components and
  related models by iterative least squares. In
  Multivariate Analysis (Ed., P.R. Krishnaiah), Academic
  Press, NY, 391-420.

  Shigeyuki Oba, Masa-aki Sato, Ichiro Takemasa, Morito
  Monden, Ken-ichi Matsubara and Shin Ishii.  A Bayesian
  missing value estimation method for gene expression
  profile data. \emph{Bioinformatics, 19(16):2088-2096, Nov
  2003}.

  Troyanskaya O. and Cantor M. and Sherlock G. and Brown P.
  and Hastie T. and Tibshirani R. and Botstein D. and
  Altman RB.  - Missing value estimation methods for DNA
  microarrays. \emph{Bioinformatics. 2001 Jun;17(6):520-5}.
}
\seealso{
  \code{\link{prcomp}}, \code{\link{princomp}},
  \code{\link{nipalsPca}}, \code{\link{svdPca}}
}
\keyword{multivariate}

