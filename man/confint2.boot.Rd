% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psymet_functions.R
\name{confint2.boot}
\alias{confint2.boot}
\title{Bootstrapped Confidence Intervals from a \code{boot} Object}
\usage{
\method{confint2}{boot}(obj, boot.ci.type = "perc", level = 0.95, ...)
}
\arguments{
\item{obj}{an object of class \code{boot} (aka an object returned by the
function \code{\link[boot]{boot}}).}

\item{boot.ci.type}{character vector of length 1 specifying the type of
bootstrapped confidence interval to compute. The options are 1) "perc" for
the regular percentile method, 2) "bca" for bias-corrected and accelerated
percentile method, 3) "norm" for the normal method that uses the
bootstrapped standard error to construct symmetrical confidence intervals
with the classic formula around the bias-corrected estimate, and 4) "basic"
for the basic method. Note, "stud" for the studentized method is NOT an
option. See \code{\link[boot]{boot.ci}} for details. Although a more
informative link is the following blogpost on bootstrapped confidence
intervals with the boot package
\url{https://www.r-bloggers.com/2019/09/understanding-bootstrap-confidence-interval-output-from-the-r-boot-package/}.}

\item{level}{double vector of length 1 specifying the confidence level. Must
be between 0 and 1.}

\item{...}{This argument has no use. Technically, it is additional arguments
for \code{confint2.boot}, but is only included for Roxygen2 to satisfy
"checking S3 generic/method consistency".}
}
\value{
data.frame will be returned with nrow equal to the number of
statistics bootstrapped and columns specified below. The rownames are the
names in the "t0" element of the \code{boot} object (default data.frame
rownames if the "t0" element does not have any names). The columns are the
following:

\describe{
   \item{est}{original parameter estimates}
   \item{se}{bootstrapped standard errors (does not differ by \code{boot.ci.type})}
   \item{lwr}{lower bound of the bootstrapped confidence intervals}
   \item{upr}{upper bound of the bootstrapped confidence intervals}
}
}
\description{
\code{confint2.boot} is the \code{boot} method for the generic function
\code{\link{confint2}} and computes bootstrapped confidence intervals from an object
of class \code{boot} (aka an object returned by the function
\code{\link[boot]{boot}}. The function is a simple wrapper for the car boot
methods for the \code{summary} and \code{confint} generics. See
\code{\link[car]{hist.boot}} for details on those methods.
}
\details{
The bias-corrected and accelerated percentile method (\code{boot.ci.type} =
"bca") will often fail if the number of bootstrapped resamples is less than
the sample size. Even still, it can fail for other reasons. Following
\code{car:::confint.boot}, \code{confint2.boot} gives a warning if the
bias-corrected and accelerated percentile method fails for any statistic, and
implicitly switches to the regular percentile method to prevent an error.
When multiple statistics were bootstrapped, it might be that the
bias-corrected and accelerated percentile method succeeded for most of the
statistics and only failed for one statistic; however, \code{confint2.boot}
will switch to using the regular percentile method for ALL the statistics.
This may change in the future.
}
\examples{

# a single statistic
mean2 <- function(x, i) mean(x[i], na.rm = TRUE)
boot_obj <- boot::boot(data = attitude[[1]], statistic = mean2, R = 200L)
confint2.boot(boot_obj)
confint2.boot(boot_obj, boot.ci.type = "bca")
confint2.boot(boot_obj, level = 0.99)

# multiple statistics
colMeans2 <- function(dat, i) colMeans(dat[i, ], na.rm = TRUE)
boot_obj <- boot::boot(data = attitude, statistic = colMeans2, R = 200L)
confint2.boot(boot_obj)
confint2.boot(boot_obj, boot.ci.type = "bca")
confint2.boot(boot_obj, level = 0.99)

}
\seealso{
\code{\link[boot]{boot.ci}}
   \code{\link[car]{hist.boot}}
}
