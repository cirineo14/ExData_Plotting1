## PLEASE NOTE: The language of my system is French.
## For this reason, the x axis in my PNG file is labelled "Jeu", "Ven", and "Sam"
## instead of "Thu", "Fri", and "Sat". Thanks for your understanding.


## Data download and creation of data frame    
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL,temp, method="curl")
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE,
                   sep=";", colClasses = "character")

## Subsetting to "1/2/2007" and "2/2/2007"
data2 <- data
data2 <- data2[data2$Date == "1/2/2007" | data2$Date == "2/2/2007",]

## Class conversion of Time column (need to add the date component)
data2$Time = paste(data2$Date, data2$Time, sep=" ")

## Class conversion of rest of columns
library(lubridate)
data2$Time = dmy_hms(data2$Time)
data2[, 3:9] = sapply(data2[, 3:9], as.numeric)

## Construction of plot
par(mfrow = c(1, 1))
par(mgp = c(2.5, 1, 0))    ## Margins of axis
plot(data2$Time, data2$Global_active_power, type = "l", cex.axis=0.75,
     xlab=NA, tck=-0.03,
     ylab="Global Active Power (kilowatts)", cex.lab=0.75)

## Creation of PNG file
dev.copy(png, file = "plot2.png", width=480, height=480)  
dev.off()