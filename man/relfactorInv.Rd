% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pedigree.R
\name{relfactorInv}
\alias{relfactorInv}
\alias{getLInv}
\title{Inverse relationship factor from a pedigree}
\usage{
relfactorInv(ped)

getLInv(ped)
}
\arguments{
\item{ped}{\code{\link{pedigree}}}
}
\value{
matrix (\code{\link[Matrix:dtCMatrix-class]{dtCMatrix}} - triangular sparse)
}
\description{
Get inverse of the left Cholesky factor of the relationship
  matrix for the pedigree \code{ped}.
}
\details{
Note that the inverse of the left Cholesky factor is returned,
  which is lower triangular, that is from A = LL' (lower %*% upper) and
  inv(A) = inv(LL') = inv(L)' inv(L) (upper %*% lower) we get inv(L) (lower
  triangular).
}
\section{Functions}{
\itemize{
\item \code{getLInv()}: Inverse relationship factor from a pedigree

}}
\examples{
ped <- pedigree(sire = c(NA, NA, 1,  1, 4, 5),
                dam =  c(NA, NA, 2, NA, 3, 2),
                label = 1:6)
(LInv <- getLInv(ped))
solve(Matrix::t(getL(ped)))

# Test for correctness
LInvExp <- matrix(data = c( 1.0000,  0.0000,  0.0000,  0.0000,  0.0000, 0.0000,
                            0.0000,  1.0000,  0.0000,  0.0000,  0.0000, 0.0000,
                           -0.7071, -0.7071,  1.4142,  0.0000,  0.0000, 0.0000,
                           -0.5774,  0.0000,  0.0000,  1.1547,  0.0000, 0.0000,
                            0.0000,  0.0000, -0.7071, -0.7071,  1.4142, 0.0000,
                            0.0000, -0.7303,  0.0000,  0.0000, -0.7303, 1.4606),
                  byrow = TRUE, nrow = 6)
stopifnot(!any(abs(round(LInv, digits = 4) - LInvExp) > .Machine$double.eps))
L <- t(chol(getA(ped)))
LInvExp <- solve(L)
stopifnot(!any(abs(LInv - LInvExp) > .Machine$double.eps))
stopifnot(is(LInv, "sparseMatrix"))
}
