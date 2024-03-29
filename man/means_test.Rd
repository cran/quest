% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describes_functions.R
\name{means_test}
\alias{means_test}
\title{Test for Multiple Sample Means Against Mu (one-sample t-tests)}
\usage{
means_test(
  data,
  vrb.nm,
  mu = 0,
  d.ci.type = "tdist",
  ci.level = 0.95,
  check = TRUE
)
}
\arguments{
\item{data}{data.frame or data.}

\item{vrb.nm}{character vector of colnames specifying the variables in
\code{data} to conduct the one-sample t-tests for.}

\item{mu}{numeric vector of length = \code{length(vrb.nm)} or length 1
specifying the population mean values to compare the sample means against.
The order of the values should be the same as the order in \code{vrb.nm}.
When length 1, the same population mean value is used for all the
variables.}

\item{d.ci.type}{character vector with length 1 of specifying the type of
confidence intervals to compute for the standardized mean differences
(i.e., Cohen's d). There are currently two options: 1. "tdist" which
calculates the confidence intervals based on the t-distribution using the
function \code{\link[psych]{cohen.d.ci}}. No standard error is calculated
for this option and NA is returned for "d_se" in the return object. 2.
"classic" which calculates the confidence intervals of Cohen's d based on
the confidence interval of the mean difference itself. The lower and upper
confidence bounds are divided by the sample standard deviation.
Technically, this confidence interval is biased due to not taking into
account the uncertainty of the standard deviations. No standard error is
calculated for this option and NA is returned for "d_se" in the return
object.}

\item{ci.level}{numeric vector of length 1 specifying the confidence level.
It must be between 0 and 1.}

\item{check}{logical vector of length 1 specifying whether the input
arguments should be checked for errors. For example, checking whether
\code{ci.level} is between 0 and 1. This is a tradeoff between
computational efficiency (FALSE) and more useful error messages (TRUE).}
}
\value{
list of data.frames containing statistical information about the
  sample means (the rownames of the data.frames are \code{vrb.nm}): 1)
  nhst = one-sample t-test stat info in a data.frame, 2) desc = descriptive
  statistics stat info in a data.frame, 3) std = standardized mean difference
  stat info in a data.frame

1) nhst = one-sample t-test stat info in a data.frame

\describe{
   \item{est}{mean - mu estimate}
   \item{se}{standard error}
   \item{t}{t-value}
   \item{df}{degrees of freedom}
   \item{p}{two-sided p-value}
   \item{lwr}{lower bound of the confidence interval}
   \item{upr}{upper bound of the confidence interval}
}

2) desc = descriptive statistics stat info in a data.frame

\describe{
   \item{mean}{mean of \code{x}}
   \item{mu}{population value of comparison}
   \item{sd}{standard deviation of \code{x}}
   \item{n}{sample size of \code{x}}
}

3) std = standardized mean difference stat info in a data.frame

\describe{
   \item{d_est}{Cohen's d estimate}
   \item{d_se}{Cohen's d standard error}
   \item{d_lwr}{Cohen's d lower bound of the confidence interval}
   \item{d_upr}{Cohen's d upper bound of the confidence interval}
}
}
\description{
\code{means_test} computes sample means and compares them against specified
population \code{mu} values. These are sometimes referred to as one-sample
t-tests. It provides the same results as \code{\link[stats]{t.test}}, but
provides the confidence intervals for the mean differences from mu rather
than the mean itself. The function also calculates the descriptive statistics
and the standardized mean differences (i.e., Cohen's d) based on the sample
standard deviations.
}
\examples{

# one-sample t-tests
means_test(data = attitude, vrb.nm = names(attitude), mu = 50)
means_test(data = attitude, vrb.nm = c("rating","complaints","privileges"),
   mu = c(60, 55, 50))
means_test(data = attitude, vrb.nm = names(attitude), mu = 50, ci.level = 0.90)
means_test(airquality, vrb.nm = names(airquality)) # different df and n due to missing data

# compare to t.test
means_test(data = attitude, vrb.nm = "rating", mu = 50, ci.level = .99)
t.test(attitude$"rating", mu = 50, conf.level = .99)

# same as intercept-only regression
means_test(data = attitude, vrb.nm = "rating")
lm_obj <- lm(rating ~ 1, data = attitude)
coef(summary(lm_obj))

}
\seealso{
\code{\link{mean_test}} one-sample t-test for a single variable,
   \code{\link[stats]{t.test}} same results,
   \code{\link{means_diff}} independent two-sample t-tests for multiple variables,
   \code{\link{means_change}} dependent two-sample t-tests for multiple variables,
}
