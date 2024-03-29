% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diary_functions.R
\name{lengths_by}
\alias{lengths_by}
\title{Length of Data Columns by Group}
\usage{
lengths_by(data, vrb.nm, grp.nm, na.rm = FALSE, sep = ".")
}
\arguments{
\item{data}{data.frame of data.}

\item{vrb.nm}{character vector of colnames from \code{data} specifying the
variables.}

\item{grp.nm}{character vector of colnames from \code{data} specifying the
groups.}

\item{na.rm}{logical vector of length 1 specifying whether to include (FALSE)
or exclude (TRUE) missing values.}

\item{sep}{character vector of length 1 specifying what string should
separate different group values when naming the return object. This
argument is only used if grp is a list of atomic vectors (e.g.,
data.frame).}
}
\value{
data.frame with colnames = \code{vrb.nm} and rownames =
  \code{length(levels(interaction(grp)))} providing the number of elements
  (excluding missing values if \code{na.rm} = TRUE) in each column by group.
}
\description{
\code{lengths_by} computes the the length of multiple columns in a data.frame
by group. The argument \code{na.rm} can be used to include (FALSE) or exclude
(TRUE) missing values. Through the use of \code{na.rm} = TRUE, the number of
observed values for each variable by each group can be computed.
}
\examples{

lengths_by(mtcars, vrb.nm = c("mpg","cyl","disp"), grp = "gear")
lengths_by(mtcars, vrb.nm = c("mpg","cyl","disp"),
   grp = c("gear","vs")) # can handle multiple grouping variables
lengths_by(mtcars, vrb.nm = c("mpg","cyl","disp"),
   grp = c("gear","am")) # can handle zero lengths
lengths_by(airquality, c("Ozone","Solar.R","Wind"), grp = "Month",
   na.rm = FALSE) # include missing values
lengths_by(airquality, c("Ozone","Solar.R","Wind"), grp = "Month",
   na.rm = TRUE) # exclude missing values

}
\seealso{
\code{\link{length_by}}
   \code{\link{length}}
   \code{\link{colNA}}
}
