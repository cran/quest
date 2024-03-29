% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quest_functions.R
\name{renames}
\alias{renames}
\title{Rename Data Columns from a Codebook}
\usage{
renames(
  data,
  codebook,
  old = 1L,
  new = 2L,
  warn_missing = TRUE,
  warn_duplicated = TRUE
)
}
\arguments{
\item{data}{data.frame of data.}

\item{codebook}{list of data.frames containing the old and new column names.}

\item{old}{numeric vector or character vector of length 1 specifying the
position or name of the column in the \code{codebook} data.frames that
contains the old column names present in \code{data}.}

\item{new}{numeric vector or character vector of length 1 specifying the
position or name of the column in the \code{codebook} data.frames that
contains the new column names to rename to in \code{data}.}

\item{warn_missing}{logical vector of length 1 specifying whether \code{renames}
should return a warning if any old names in \code{codebook} are not present in
\code{data}.}

\item{warn_duplicated}{logical vector of length 1 specifying whether \code{renames}
should return a warning if the renaming process results in duplicate column names
in the return object.}
}
\value{
data.frame identical to \code{data} except that the old names in
\code{codebook} have been replaced by the new names in \code{codebook}.
}
\description{
\code{renames} renames columns in a data.frame from a codebook. The codebook is
assumed to be a list of data.frames containing the old and new column names.
See details for how the codebook should be structured. The idea is that the
codebook has been imported as an excel workbook with different sets of column
renaming information in different workbook sheets. This function is simply a wrapper
for \code{plyr::rename}.
}
\details{
\code{codebook} is a list of data.frames where one column refers to the old names
and another column refers to the new names. Therefore, each row of the data.frames
refers to a column in \code{data}. The position or names of the columns in the
\code{codebook} data.frames that contain the old (i.e., \code{old}) and new
(i.e., \code{new}) \code{data} columns must be the same for each data.frame in
\code{codebook}.
}
\examples{
code_book <- list(
   data.frame("old" = c("rating","complaints"), "new" = c("RATING","COMPLAINTS")),
   data.frame("old" = c("privileges","learning"), "new" = c("PRIVILEGES","LEARNING"))
)
renames(data = attitude, codebook = code_book, old = "old", new = "new")
}
\seealso{
\code{\link[plyr]{rename}}
}
