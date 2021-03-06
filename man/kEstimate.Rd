\name{kEstimate}
\alias{kEstimate}
\title{Estimate best number of Components for missing value
estimation}
\usage{
  kEstimate(Matrix, method = "ppca", evalPcs = 1:3,
    segs = 3, nruncv = 5, em = "q2", allVariables = FALSE,
    verbose = interactive(), ...)
}
\arguments{
  \item{Matrix}{\code{matrix} -- numeric matrix containing
  observations in rows and variables in columns}

  \item{method}{\code{character} -- of the methods found
  with pcaMethods() The option llsImputeAll calls llsImpute
  with the allVariables = TRUE parameter.}

  \item{evalPcs}{\code{numeric} -- The principal components
  to use for cross validation or the number of neighbour
  variables if used with llsImpute.  Should be an array
  containing integer values, eg. \code{evalPcs = 1:10} or
  \code{evalPcs = c(2,5,8)}. The NRMSEP or Q2 is calculated
  for each component.}

  \item{segs}{\code{numeric} -- number of segments for
  cross validation}

  \item{nruncv}{\code{numeric} -- Times the whole cross
  validation is repeated}

  \item{em}{\code{character} -- The error measure. This can
  be nrmsep or q2}

  \item{allVariables}{\code{boolean} -- If TRUE, the NRMSEP
  is calculated for all variables, If FALSE, only the
  incomplete ones are included. You maybe want to do this
  to compare several methods on a complete data set.}

  \item{verbose}{\code{boolean} -- If TRUE, some output
  like the variable indexes are printed to the console each
  iteration.}

  \item{...}{Further arguments to \code{pca} or \code{nni}}
}
\value{
  A list with: \item{bestNPcs}{number of PCs or k for which
  the minimal average NRMSEP or the maximal Q2 was
  obtained.} \item{eError}{an array of of size
  length(evalPcs). Contains the average error of the cross
  validation runs for each number of components.}
  \item{variableWiseError}{Matrix of size
  \code{incomplete_variables} x length(evalPcs).  Contains
  the NRMSEP or Q2 distance for each variable and each
  number of PCs. This allows to easily see for wich
  variables imputation makes sense and for which one it
  should not be done or mean imputation should be used.}
  \item{evalPcs}{The evaluated numbers of components or
  number of neighbours (the same as the evalPcs input
  parameter).} \item{variableIx}{Index of the incomplete
  variables. This can be used to map the variable wise
  error to the original data.}
}
\description{
  Perform cross validation to estimate the optimal number
  of components for missing value estimation. Cross
  validation is done for the complete subset of a variable.
}
\details{
  The assumption hereby is that variables that are highly
  correlated in a distinct region (here the non-missing
  observations) are also correlated in another (here the
  missing observations).  This also implies that the
  complete subset must be large enough to be
  representative.  For each incomplete variable, the
  available values are divided into a user defined number
  of cv-segments. The segments have equal size, but are
  chosen from a random equal distribution. The non-missing
  values of the variable are covered completely.  PPCA,
  BPCA, SVDimpute, Nipals PCA, llsImpute an NLPCA may be
  used for imputation.

  The whole cross validation is repeated several times so,
  depending on the parameters, the calculations can take
  very long time.  As error measure the NRMSEP (see Feten
  et. al, 2005) or the Q2 distance is used.  The NRMSEP
  basically normalises the RMSD between original data and
  estimate by the variable-wise variance. The reason for
  this is that a higher variance will generally lead to a
  higher estimation error.  If the number of samples is
  small, the variable - wise variance may become an
  unstable criterion and the Q2 distance should be used
  instead. Also if variance normalisation was applied
  previously.

  The method proceeds variable - wise, the NRMSEP / Q2
  distance is calculated for each incomplete variable and
  averaged afterwards. This allows to easily see for wich
  set of variables missing value imputation makes senes and
  for wich set no imputation or something like
  mean-imputation should be used.  Use \code{kEstimateFast}
  or \code{Q2} if you are not interested in variable wise
  CV performance estimates.

  Run time may be very high on large data sets. Especially
  when used with complex methods like BPCA or Nipals PCA.
  For PPCA, BPCA, Nipals PCA and NLPCA the estimation
  method is called \eqn{(v_{miss} \cdot segs \cdot nruncv
  \cdot)}{(v\_miss * segs * nruncv)} times as the error for
  all numbers of principal components can be calculated at
  once.  For LLSimpute and SVDimpute this is not possible,
  and the method is called \eqn{(v_{miss} \cdot segs \cdot
  nruncv \cdot length(evalPcs))}{(v\_miss * segs * nruncv *
  length(evalPcs))} times. This should still be fast for
  LLSimpute because the method allows to choose to only do
  the estimation for one particular variable.  This saves a
  lot of iterations.  Here, \eqn{v_{miss}}{v\_miss} is the
  number of variables showing missing values.

  As cross validation is done variable-wise, in this
  function Q2 is defined on single variables, not on the
  entire data set. This is Q2 is calculated as as
  \eqn{\frac{\sum(x - xe)^2}{\sum(x^2)}}{sum(x - xe)^2 \
  sum(x^2)}, where x is the currently used variable and xe
  it's estimate. The values are then averaged over all
  variables. The NRMSEP is already defined variable-wise.
  For a single variable it is then \eqn{\sqrt(\frac{\sum(x
  - xe)^2}{(n \cdot var(x))})}{sqrt(sum(x - xe)^2 \ (n *
  var(x)))}, where x is the variable and xe it's estimate,
  n is the length of x.  The variable wise estimation
  errors are returned in parameter variableWiseError.
}
\examples{
## Load a sample metabolite dataset with 5\\\% missing values (metaboliteData)
data(metaboliteData)
# Do cross validation with ppca for component 2:4
esti <- kEstimate(metaboliteData, method = "ppca", evalPcs = 2:4, nruncv=1, em="nrmsep")
# Plot the average NRMSEP
barplot(drop(esti$eError), xlab = "Components",ylab = "NRMSEP (1 iterations)")
# The best result was obtained for this number of PCs:
print(esti$bestNPcs)
# Now have a look at the variable wise estimation error
barplot(drop(esti$variableWiseError[, which(esti$evalPcs == esti$bestNPcs)]),
        xlab = "Incomplete variable Index", ylab = "NRMSEP")
}
\author{
  Wolfram Stacklies
}
\seealso{
  \code{\link{kEstimateFast}, \link{Q2}, \link{pca},
  \link{nni}}.
}
\keyword{multivariate}

