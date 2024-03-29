% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quest_functions.R
\name{shifts}
\alias{shifts}
\title{Shift Data (i.e., lag/lead)}
\usage{
shifts(data, vrb.nm, n, undefined = NA, suffix)
}
\arguments{
\item{data}{data.frame of data.}

\item{vrb.nm}{character vector of colnames from \code{data} specifying the
variables.}

\item{n}{integer vector of length 1. Specifies the direction and magnitude of
the shift. See details.}

\item{undefined}{atomic vector of length 1 (probably makes sense to be the
same typeof as the vectors in \code{data[vrb.nm]}). Specifies what to
insert for undefined values after the shifting takes place. See details.}

\item{suffix}{character vector of length 1 specifying the string to append to
the end of the colnames of the return object. The default depends on the
\code{n} argument: 1) if \code{n} < 0, then \code{suffix} =
\code{paste0("_g", -n)}, 2) if \code{n} > 0, then \code{suffix} =
\code{paste0("_d", +n)}, 3) if \code{n} = 0, then \code{suffix} = "".}
}
\value{
data.frame of shifted data with colnames specified by \code{suffix}.
}
\description{
\code{shifts} shifts rows of data down (\code{n} < 0) for lags or up (\code{n}
> 0) for leads replacing the undefined data with a user-defined value (e.g.,
NA). The number of rows shifted is equal to \code{abs(n)}. It is assumed that
\code{data[vrb.nm]} is already sorted by time such that the first row is
earliest in time and the last row is the latest in time.
}
\details{
If \code{n} is negative, then \code{shifts} inserts \code{undefined} into the
first \code{abs(n)} rows of \code{data[vrb.nm]}, shifting all other rows of
\code{x} down \code{abs(n)} positions, and then dropping the last
\code{abs(n)} row of \code{data[vrb.nm]} to preserve the original nrow of
\code{data}. If \code{n} is positive, then \code{shifts} drops the first
\code{abs(n)} rows of \code{x}, shifting all other rows of
\code{data[vrb.nm]} up \code{abs(n)} positions, and then inserts
\code{undefined} into the last \code{abs(n)} rows of \code{x} to preserve the
original length of \code{data}. If \code{n} is zero, then \code{shifts} simply
returns \code{data[vrb.nm]}.

It is recommended to use \code{L} when specifying \code{n} to prevent
problems with floating point numbers. \code{shifts} tries to circumvent this
issue by a call to \code{round} within \code{shifts} if \code{n} is not an
integer; however that is not a complete fail safe. The problem is that
\code{as.integer(n)} implicit in \code{shifts} truncates rather than rounds.
}
\examples{
shifts(data = attitude, vrb.nm = colnames(attitude), n = -1L)
shifts(data = mtcars, vrb.nm = colnames(mtcars), n = 2L)
}
\seealso{
\code{\link{shift}}
   \code{\link{shifts_by}}
   \code{\link{shift_by}}
}
