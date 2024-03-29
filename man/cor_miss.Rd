% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describes_functions.R
\name{cor_miss}
\alias{cor_miss}
\title{Point-biserial Correlations of Missingness}
\usage{
cor_miss(
  data,
  x.nm,
  m.nm,
  ov = FALSE,
  use = "pairwise.complete.obs",
  method = "pearson"
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
}
\value{
numeric matrix of (point-biserial) correlations between rows of
  predictors and columns of missingness.
}
\description{
\code{cor_miss} computes (point-biserial) correlations between missingness on
data columns and scores on other data columns.
}
\details{
\code{cor_miss} calls \code{\link{make.dumNA}} to create dummy vectors representing
missingness on the \code{data[m.nm]} columns.
}
\examples{

cor_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"))
cor_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"), ov = TRUE) # correlations with "observedness"
cor_miss(data = airquality, x.nm = c("Wind","Temp","Month","Day"),
   m.nm = c("Ozone","Solar.R"), use = "complete.obs", method = "kendall")

}
