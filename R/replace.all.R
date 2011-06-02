#' \code{replace.all} is a wrapper around \code{replace}.
#'
#' @param x vector
#' @param what list of values to replace (usually one or more character strings)
#' @param value replacement value 
#' @return a vector with the values replaced.
replace.all <- function(x, what, value) {
	replace(x, which(x %in% what), value)
}