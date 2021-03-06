\name{biplot.pcaRes}
\alias{biplot.pcaRes}
\title{Plot a overlaid scores and loadings plot}
\usage{
  \method{biplot}{pcaRes} (x, choices = 1:2, scale = 1,
    pc.biplot = FALSE, ...)
}
\arguments{
  \item{x}{a pcaRes object}

  \item{choices}{which two pcs to plot}

  \item{scale}{The variables are scaled by
  \eqn{\lambda^{scale}}{lambda^scale} and the observations
  are scaled by \eqn{\lambda^{scale}}{lambda ^ (1-scale)}
  where \code{lambda} are the singular values as computed
  by \code{princomp}.  Normally \eqn{0\le{}scale\le{}1}{0
  <= scale <= 1}, and a warning will be issued if the
  specified 'scale' is outside this range.}

  \item{pc.biplot}{If true, use what Gabriel (1971) refers
  to as a "principal component biplot", with
  \eqn{\lambda=1}{lambda = 1} and observations scaled up by
  sqrt(n) and variables scaled down by sqrt(n). Then the
  inner products between variables approximate covariances
  and distances between observations approximate
  Mahalanobis distance.}

  \item{...}{optional arguments to be passed to
  \code{biplot.default}.}
}
\value{
  a plot is produced on the current graphics device.
}
\description{
  Visualize two-components simultaneously
}
\details{
  This is a method for the generic function 'biplot'.
  There is considerable confusion over the precise
  definitions: those of the original paper, Gabriel (1971),
  are followed here.  Gabriel and Odoroff (1990) use the
  same definitions, but their plots actually correspond to
  \code{pc.biplot = TRUE}.
}
\examples{
data(iris)
pcIr <- pca(iris[,1:4])
biplot(pcIr)
}
\author{
  Kevin Wright, Adapted from \code{biplot.prcomp}
}
\seealso{
  \code{prcomp}, \code{pca}, \code{princomp}
}
\keyword{multivariate}

