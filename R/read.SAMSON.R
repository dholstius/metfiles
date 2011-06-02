#' Read SAMSON meteorological data.
#'
#' @param file the file to read
#' @param \dots further arguments to be passed to \code{read.fortran()}
#' @return a data.frame with the data contained in the file
#' @export
read.SAMSON <- function(file, raw.values=FALSE, pretty.names=TRUE, ...) {
	conn <- file(path, open="r")
	line <- readLines(conn, n=1)
	header <- list(
		station   = substr(line, 2, 6),
		city      = substr(line, 8, 29),
		state     = substr(line, 31, 32),
		time.zone = substr(line, 33, 36),
		latitude  = substr(line, 39, 44),
		longitude = substr(line, 47, 53),
		elevation = substr(line, 56, 59))
	line <- readLines(conn, n=1)
	matches <- gregexpr("[ ]*[^ ]+", line)[[1]]
	widths <- attr(matches, "match.length")
	contents <- suppressWarnings(read.fwf(conn, widths, skip=2))
	close(conn)
	first <- matches
	last <- c(start[2:length(start)], nchar(line) + 1) - 1
	raw.names <- substring(line, first, last)
	raw.names <- gsub("[ ]+", "", raw.names)
	name.lookup <- list(
		`~YR` = "Year",
		MO = "Month",
		DA = "Day",
		HR = "Hour",
		I = "Observation indicator",
		`1` = "Extraterrestrial horizontal radiation",
		`2` = "Extraterrestrial direct normal radiation",
		`3` = "Global horizontal radiation",
		`4` = "Direct normal radiation",
		`5` = "Diffuse horizontal radiation",
		`6` = "Total cloud cover",
		`7` = "Opaque cloud cover",
		`8` = "Dry bulb temperature",
		`9` = "Dew point temperature",
		`10` = "Relative humidity",
		`11` = "Station pressure",
		`12` = "Wind direction",
		`13` = "Wind speed",
		`14` = "Visibility",
		`15` = "Ceiling height",
		`16` = "Present weather",
		`17` = "Precipitable water",
		`18` = "Broadband aerosol optical depth",
		`19` = "Snow depth",
		`20` = "Days since last snowfall",
		`21` = "Hourly precipitation")
	names(contents) <- raw.names
	if(!raw.values) {
		contents <- transform(contents,
			`15` = replace.all(`15`, "77777", NA),
			`16` = replace.all(`16`, "999999999", NA))
	}
	names(contents) <- raw.names
	if(pretty.names) {
		names(contents) <- name.lookup[names(contents)]
	}
	return(list(header=header, records=contents))
}
file <- system.file("extdata", "SAMSON", "samsonexcerpt.txt", package="metfiles")
met.data <- read.SAMSON(file)
head(met.data$records)