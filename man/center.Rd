% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quest_functions.R
\name{center}
\alias{center}
\title{Centering and/or Standardizing a Numeric Vector}
\usage{
center(x, center = TRUE, scale = FALSE)
}
\arguments{
\item{x}{numeric vector.}

\item{center}{logical vector with length 1 specifying whether grand-mean
centering should be done.}

\item{scale}{logical vector with length 1 specifying whether grand-SD scaling
should be done.}
}
\value{
numeric vector of \code{x} centered and/or standardized with the same
  names as \code{x}.
}
\description{
\code{center} centers and/or standardized a numeric vector. It is an
alternative to \code{scale.default} that returns a numeric vector rather than
a numeric matrix.
}
\details{
\code{center} first coerces \code{x} to a matrix in preparation for the call
to \code{scale.default}. If the coercion results in a non-numeric matrix
(e.g., \code{x} is a character vector or factor), then an error is returned.
}
\examples{
center(x = mtcars$"disp")
center(x = mtcars$"disp", scale = TRUE)
center(x = mtcars$"disp", center = FALSE, scale = TRUE)
center(x = setNames(mtcars$"disp", nm = row.names(mtcars)))
}
\seealso{
\code{\link{centers}}
   \code{\link{center_by}}
   \code{\link{centers_by}}
   \code{\link{scale.default}}
}
