#' Read SCRAM surface meteorological data.
#'
#' @param file the file to read
#' @param \dots further arguments to be passed to \code{read.fwf()}
#' @return a data.frame with the data contained in the file
#' @export
#' @seealso \code{\link{read.SCRAM.upper}}
#' @references
#' \url{http://www.epa.gov/scram001/surface/surfor.txt}
read.SCRAM.surface <- function(file, ...) {
	cols <- list(
		station = 'character',				# NWS station number
		year = 'integer',
		month = 'integer',
		day = 'integer',
		hour = 'integer',
		ceiling.height = 'character',		# Hundreds of feet
		wind.directon = 'numeric',			# Tens of degrees
		wind.speed = 'numeric',				# Knots
		dry.bulb.temperature = 'numeric',	# Degrees Fahrenheit
		total.cloud.cover = 'numeric',		# Tens of percent
		opaque.cloud.cover = 'numeric')		# Tens of percent
	widths <- c(5, 2, 2, 2, 2, 3, 2, 3, 3, 2, 2)
	raw.contents <- read.fwf(file, widths, colClasses=cols, col.names=names(cols))
	clean.contents <- transform(contents, ceiling.height=clean.numeric(ceiling.height))
	return(clean.contents)
}