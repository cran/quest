% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quest_functions.R
\name{wide2long}
\alias{wide2long}
\title{Reshape Multiple Sets of Variables From Wide to Long}
\usage{
wide2long(
  data,
  vrb.nm.list,
  grp.nm = NULL,
  sep = ".",
  rtn.obs.nm = "obs",
  order.by.grp = TRUE,
  keep.attr = FALSE
)
}
\arguments{
\item{data}{data.frame of multilevel data in the wide format.}

\item{vrb.nm.list}{A unique argument for the \code{quest} package such that
it can take on different types of inputs. The conventional use is to
provide a list of character vectors specifying each set of colnames to be
reshaped. In longitudinal panel data, each list element would contain a
score with multiple timepoints. The advanced use is to provide a single
character vector specifying the colnames to be reshaped (not organized by
sets). See details.}

\item{grp.nm}{character vector specifying the colnames in \code{data}
corresponding to the groups. Because \code{data} is in the wide format,
\code{data[grp.nm]} must have unique rows (aka groups); if this is not the
case, an error is returned. \code{grp.nm} can be NULL, in which case the
rownames of \code{data} will be used. In longitudinal panel data this
variable would be the participant ID variable.}

\item{sep}{character vector of length 1 specifying the string in the column
names provided by \code{vrb.nm.list} that separates out the name prefix
from the number suffix. If \code{sep} = "", then that implies there is no
string separating the name prefix and the number suffix (e.g., "outcome1").}

\item{rtn.obs.nm}{character vector of length 1 specifying the new colname in
the return object indicating which observation within each group the row
refers to. In longitudinal panel data, this would be the returned time
variable.}

\item{order.by.grp}{logical vector of length 1 specifying whether to sort the
return object first by \code{grp.nm} and then \code{obs.nm} (TRUE) or by
\code{obs.nm} and then \code{grp.nm} (FALSE).}

\item{keep.attr}{logical vector of length 1 specifying whether to keep the
"reshapeLong" attribute (from \code{\link[stats]{reshape}}) in the return
object.}
}
\value{
data.frame with nrow equal to \code{nrow(data) *
  length(vrb.nm.list[[1]])} if \code{vrb.nm.list} is a list (i.e.,
  conventional use) or \code{nrow(data)} * number of unique number suffixes
  in \code{vrb.nm.list} if \code{vrb.nm.list} is not a list (i.e., advanced
  use). The columns will be in the following order: 1) \code{grp.nm} of the
  groups, 2) \code{rtn.obs.nm} of the observation labels, 3) the reshaped
  columns, 4) the additional columns that were not reshaped and instead
  repeated. How the returned data.frame is sorted depends on
  \code{order.by.grp}.
}
\description{
\code{wide2long} reshapes data from wide to long. This if often necessary to
do with multilevel data where multiple sets of variables in the wide format
seek to be reshaped to multiple rows in the long format. If only one set of
variables needs to be reshaped, then you can use
\code{\link[str2str]{stack2}} or \code{\link[reshape]{melt.data.frame}} - but that
does not work for *multiple* sets of variables. See details for more
information.
}
\details{
\code{wide2long} uses \code{reshape(direction = "long")} to reshape the data.
It attempts to streamline the task of reshaping wide to long as the
\code{reshape} arguments can be confusing because the same arguments are used
for wide vs. long reshaping. See \code{\link[stats]{reshape}} if you are
curious.

IF \code{vrb.nm.list} IS A LIST OF CHARACTER VECTORS: The conventional use of
\code{vrb.nm.list} is to provide a list of character vectors, which specify
each set of variables to be reshaped. For example, if \code{data} contains
data from a longitudinal panel study with the same scores at different waves,
then there might be a column for each score at each wave. \code{vrb.nm.list}
would then contain an element for each score with each element containing a
character vector of the colnames for that score at each wave (see examples).
The names of the list elements would then be the colnames in the return
object for those scores.

IF \code{vrb.nm.list} IS A CHARACTER VECTOR: The advanced use of
\code{vrb.nm.list} is to provide a single character vector, which specify the
variables to be reshaped (not organized by sets). In this case (i.e., if
\code{vrb.nm.list} is not a list), then \code{wide2long} (really
\code{\link[stats]{reshape}}) will attempt to guess which colnames go
together as a set. It is assumed the following column naming scheme has been
used: 1) have the same name prefix for columns within a set, 2) have the same
number suffixes for each set of columns, 3) use, *and only use*, \code{sep}
in the colnames to separate the name prefix and the number suffix. For
example, the name prefixes might be "predictor" and "outcome" while the
number suffixes might be "0", "1", and "2", and the separator might be ".",
resulting in column names such as "outcome.1". The name prefix could include
separators other than \code{sep} (e.g., "outcome_item.1"), but it cannot
include \code{sep} (e.g., "outcome.item.1"). So "outcome_item1.1" could be
acceptable, but "outcome.item1.1" would not.
}
\examples{

# SINGLE GROUPING VARIABLE
dat_wide <- data.frame(
   x_1.1 = runif(5L),
   x_2.1 = runif(5L),
   x_3.1 = runif(5L),
   x_4.1 = runif(5L),
   x_1.2 = runif(5L),
   x_2.2 = runif(5L),
   x_3.2 = runif(5L),
   x_4.2 = runif(5L),
   x_1.3 = runif(5L),
   x_2.3 = runif(5L),
   x_3.3 = runif(5L),
   x_4.3 = runif(5L),
   y_1.1 = runif(5L),
   y_2.1 = runif(5L),
   y_1.2 = runif(5L),
   y_2.2 = runif(5L),
   y_1.3 = runif(5L),
   y_2.3 = runif(5L))
row.names(dat_wide) <- letters[1:5]
print(dat_wide)

# vrb.nm.list = list of character vectors (conventional use)
vrb_pat <- c("x_1","x_2","x_3","x_4","y_1","y_2")
vrb_nm_list <- lapply(X = setNames(vrb_pat, nm = vrb_pat), FUN = function(pat) {
   str2str::pick(x = names(dat_wide), val = pat, pat = TRUE)})
# without `grp.nm`
z1 <- wide2long(dat_wide, vrb.nm = vrb_nm_list)
# with `grp.nm`
dat_wide$"ID" <- letters[1:5]
z2 <- wide2long(dat_wide, vrb.nm = vrb_nm_list, grp.nm = "ID")
dat_wide$"ID" <- NULL

# vrb.nm.list = character vector + guessing (advanced use)
vrb_nm <- str2str::pick(x = names(dat_wide), val = "ID", not = TRUE)
# without `grp.nm`
z3 <- wide2long(dat_wide, vrb.nm.list = vrb_nm)
# with `grp.nm`
dat_wide$"ID" <- letters[1:5]
z4 <- wide2long(dat_wide, vrb.nm = vrb_nm, grp.nm = "ID")
dat_wide$"ID" <- NULL

# comparisons
head(z1); head(z3); head(z2); head(z4)
all.equal(z1, z3)
all.equal(z2, z4)
# keeping the reshapeLong attributes
z7 <- wide2long(dat_wide, vrb.nm = vrb_nm_list, keep.attr = TRUE)
attributes(z7)

# MULTIPLE GROUPING VARIABLES
bfi2 <- psych::bfi
bfi2$"person" <- unlist(lapply(X = 1:400, FUN = rep.int, times = 7))
bfi2$"day" <- rep.int(1:7, times = 400L)
head(bfi2, n = 15)

# vrb.nm.list = list of character vectors (conventional use)
vrb_pat <- c("A","C","E","N","O")
vrb_nm_list <- lapply(X = setNames(vrb_pat, nm = vrb_pat), FUN = function(pat) {
   str2str::pick(x = names(bfi2), val = pat, pat = TRUE)})
z5 <- wide2long(bfi2, vrb.nm.list = vrb_nm_list, grp = c("person","day"),
   rtn.obs.nm = "item")

# vrb.nm.list = character vector + guessing (advanced use)
vrb_nm <- str2str::pick(x = names(bfi2),
   val = c("person","day","gender","education","age"), not = TRUE)
z6 <- wide2long(bfi2, vrb.nm.list = vrb_nm, grp = c("person","day"),
   sep = "", rtn.obs.nm = "item") # need sep = "" because no character separating
   # scale name and item number
all.equal(z5, z6)

}
\seealso{
\code{\link{long2wide}}
   \code{\link[stats]{reshape}}
   \code{\link[str2str]{stack2}}
}
