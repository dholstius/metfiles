#' Read SCRAM upper-air meteorological data.
#'
#' @param file the file to read
#' @param \dots further arguments to be passed to \code{read.fwf()}
#' @return a data.frame with the data contained in the file
#' @export
#' @seealso \code{\link{read.SCRAM.surface}}
read.SCRAM.upper <- function(file, ...) {
	cols <- list(
		station = 'character',
		year = 'integer',
		month = 'integer',
		day = 'integer',
		am = 'numeric',
		pm = 'numeric')
	widths <- c(5, 2, 2, 2, 4, 4)
	raw.contents <- read.fwf(file, widths, colClasses=cols, col.names=names(cols), ...)
	return(raw.contents)
}
