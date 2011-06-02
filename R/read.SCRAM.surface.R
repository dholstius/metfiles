#' Read surface meteorological data from a file.
#'
#' @param file the file to read
#' @param \dots further arguments to be passed to \code{read.fwf()}
#' @return a data.frame with the data contained in the file
#' @export
#' @seealso \code{\link{read.SCRAM.upper}}
#' @references
#' \url{http://www.epa.gov/scram001/surface/surfor.txt}
read.SCRAM.surface <- function(file, ...) {
	columns <- list(
		station = 'character',
		year = 'integer',
		month = 'integer',
		day = 'integer',
		hour = 'integer',
		ceiling.height = 'character',
		wind.directon = 'numeric',
		wind.speed = 'numeric',
		dry.bulb.temperature = 'numeric',
		total.cloud.cover = 'numeric',
		opaque.cloud.cover = 'numeric')
	col.names <- c(
		'station',				# NWS station number
		'year','month','day','hour',
		'ceiling.height',			# Hundreds of feet
		'wind.direction',			# Tens of degrees
		'wind.speed',				# Knots
		'dry.bulb.temperatue',		# Degrees Fahrenheit
		'total.cloud.cover',		# Tens of percent
		'opaque.cloud.cover')		# Tens of percent
	widths <- c(5, 2, 2, 2, 2, 3, 2, 3, 3, 2, 2)
	contents <- read.fwf(file, widths, colClasses=columns, col.names=names(columns))
	transform(contents, ceiling.height=clean.numeric(ceiling.height))
}