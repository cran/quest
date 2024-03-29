% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describes_functions.R
\name{mean_test}
\alias{mean_test}
\title{Test for Sample Mean Against Mu (one-sample t-test)}
\usage{
mean_test(x, mu = 0, d.ci.type = "tdist", ci.level = 0.95, check = TRUE)
}
\arguments{
\item{x}{numeric vector.}

\item{mu}{numeric vector of length 1 specifying the population mean value to
compare the sample mean against.}

\item{d.ci.type}{character vector with length 1 specifying the type of
confidence interval to compute for the standardized mean difference (i.e.,
Cohen's d). There are currently two options: 1. "tdist" which calculates
the confidence intervals based on the t-distribution using the function
\code{\link[psych]{cohen.d.ci}}. No standard error is calculated for this
option and NA is returned for "d_se" in the return object. 2. "classic"
which calculates the confidence interval of Cohen's d based on the
confidence interval of the mean difference itself. The lower and upper
confidence bounds are divided by the sample standard deviation.
Technically, this confidence interval is biased due to not taking into
account the uncertainty of the standard deviations. No standard error is
calculated for this option and NA is returned for "d_se" in the return
object.}

\item{ci.level}{numeric vector of length 1 specifying the confidence level.
It must be between 0 and 1.}

\item{check}{logical vector of length 1 specifying whether the input
arguments should be checked for errors. For example, checking whether
\code{x} is a numeric vector. This is a tradeoff between computational
efficiency (FALSE) and more useful error messages (TRUE).}
}
\value{
list of numeric vectors containing statistical information about the
  sample mean: 1) nhst = one-sample t-test stat info in a numeric vector,
  2) desc = descriptive statistics stat info in a numeric vector,
  3) std = standardized mean difference stat info in a numeric vector

1) nhst = one-sample t-test stat info in a numeric vector

\describe{
   \item{est}{mean - mu estimate}
   \item{se}{standard error}
   \item{t}{t-value}
   \item{df}{degrees of freedom}
   \item{p}{two-sided p-value}
   \item{lwr}{lower bound of the confidence interval}
   \item{upr}{upper bound of the confidence interval}
}

2) desc = descriptive statistics stat info in a numeric vector

\describe{
   \item{mean}{mean of \code{x}}
   \item{mu}{population value of comparison}
   \item{sd}{standard deviation of \code{x}}
   \item{n}{sample size of \code{x}}
}

3) std = standardized mean difference stat info in a numeric vector

\describe{
   \item{d_est}{Cohen's d estimate}
   \item{d_se}{Cohen's d standard error}
   \item{d_lwr}{Cohen's d lower bound of the confidence interval}
   \item{d_upr}{Cohen's d upper bound of the confidence interval}
}
}
\description{
\code{mean_test} computes the sample mean and compares it against a specified
population \code{mu} value. This is sometimes referred to as a one-sample
t-test. It provides the same results as \code{\link[stats]{t.test}}, but
provides the confidence interval for the mean difference from mu rather than
the mean itself. The function also calculates the descriptive statistics and
the standardized mean difference (i.e., Cohen's d) based on the sample
standard deviation.
}
\examples{

# one-sample t-test
mean_test(x = mtcars$"mpg")
mean_test(x = attitude$"rating", mu = 50)
mean_test(x = attitude$"rating", mu = 50, d.ci.type = "classic")

# compare to t.test()
mean_test(x = attitude$"rating", mu = 50, ci.level = .99)
t.test(attitude$"rating", mu = 50, conf.level = .99)

# same as intercept-only regression when mu = 0
mean_test(x = mtcars$"mpg")
lm_obj <- lm(mpg ~ 1, data = mtcars)
coef(summary(lm_obj))

}
\seealso{
\code{\link{means_test}} one-sample t-tests for multiple variables,
   \code{\link[stats]{t.test}} same results,
   \code{\link{mean_diff}} independent two-sample t-test,
   \code{\link{mean_change}} dependent two-sample t-test,
}
