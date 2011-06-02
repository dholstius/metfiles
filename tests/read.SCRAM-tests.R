library(metfiles)
path <- system.file("extdata", "SCRAM", "surface", "S9319391.DAT", package="metfiles")
met.data <- read.SCRAM.surface(path)
summary(met.data)