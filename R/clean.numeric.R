#' Replace user-specified "missing data" codes with NA and convert to numeric.
#'
#' @param x the array to clean
#' @param missing a list of codes considered equivalent to NA
#' @return a numeric array
clean.numeric <- function(x, missing=list('---')) {
	as.numeric(replace(x, which(x %in% missing), NA))
}