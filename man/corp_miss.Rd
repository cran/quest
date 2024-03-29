% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describes_functions.R
\name{corp_miss}
\alias{corp_miss}
\title{Point-biserial Correlations of Missingness With Significant Symbols}
\usage{
corp_miss(
  data,
  x.nm,
  m.nm,
  ov = FALSE,
  use = "pairwise.complete.obs",
  method = "pearson",
  m.suffix = if (ov) "_ov" else "_na",
  digits = 3L,
  p.10 = "",
  p.05 = "*",
  p.01 = "**",
  p.001 = "***",
  lead.zero = FALSE,
  trail.zero = TRUE,
  plus = FALSE
)
}
\arguments{
\item{data}{data.frame of data.}

\item{x.nm}{character vector of colnames in \code{data} to be the predictors
of missingness.}

\item{m.nm}{character vector of colnames in \code{data} to specify missing
data on.}

\item{ov}{logical vector of length 1 specifying whether the correlations
should be with "observedness" rather than missingness.}

\item{use}{character vector of length 1 specifying how to deal with missing
data in the predictor columns. See \code{\link[stats]{cor}}.}

\item{method}{character vector of length 1 specifying what type of
correlations to compute. See \code{\link[stats]{cor}}.}

\item{m.suffix}{character vector of length 1 specifying a string to oppend to
the end of the colnames to clarify whether they refer to missingness or
"observedness". Default is "_na" if \code{ov} = FALSE and "_ov" if
\code{ov} = TRUE.}

\item{digits}{integer vector of length 1 specifying the number of decimals to
round to.}

\item{p.10}{character vector of length 1 specifying which symbol to append to
the end of any correlation significant at the p < .10 level.}

\item{p.05}{character vector of length 1 specifying which symbol to append to
the end of any correlation significant at the p < .05 level.}

\item{p.01}{character vector of length 1 specifying which symbol to append to
the end of any correlation significant at the p < .01 level.}

\item{p.001}{character vector of length 1 specifying which symbol to append
to the end of any correlation significant at the p < .001 level.}

\item{lead.zero}{logical vector of length 1 specifying whether to retain a
zero in front of the decimal place.}

\item{trail.zero}{logical vector of length 1 specifying whether to retain
zeros after the decimal place (due to rounding).}

\item{plus}{logical vector of length 1 specifying whether to include a plus
sign in front of positive correlations (minus signs are always in front of
negative correlations).}
}
\value{
numeric matrix of (point-biserial) correlations between rows of
  predictors and columns of missingness.
}
\description{
\code{corp_miss} computes (point-biserial) correlations between missingness
on data columns and scores on other data columns. It also appends
significance symbols at the end of the correlations.
}
\details{
\code{cor_miss} calls \code{make.dumNA} to create dummy vectors representing
missingness on the \code{data[m.nm]} columns.
}
\examples{

corp_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"))
corp_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"), ov = TRUE) # correlations with "observedness"
corp_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"), use = "complete.obs", method = "kendall")

}
