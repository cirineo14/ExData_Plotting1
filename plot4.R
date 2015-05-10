## PLEASE NOTE: The language of my system is French.
## For this reason, the x axis in my PNG file are labelled "Jeu", "Ven", and "Sam"
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

par(mfrow = c(2, 2))
## Set the margins for the four plots
par(mar = c(4, 4, 1, 1))
## Set the margins of the axis
par(mgp = c(2, 0.5, 0))

with(data2, {
        ## Top left plot
        plot(data2$Time, data2$Global_active_power, type = "l", cex.axis=0.75,
             xlab=NA, tck=-0.03,
             ylab="Global Active Power", cex.lab=0.75)
        
        ## Top right plot
        plot(data2$Time, data2$Voltage, type = "l", cex.axis=0.75,
             xlab="datetime", tck=-0.03,
             ylab="Voltage", cex.lab=0.75)
                
        ## Bottom left plot
        plot(data2$Time, data2$Sub_metering_1,
             ylim=range(c(data2$Sub_metering_1, data2$Sub_metering_2, data2$Sub_metering_3)),
             bty="n", type="l", xlab=NA, ylab=NA, xaxt="n", yaxt="n")
        par(new = TRUE)
        plot(data2$Time, data2$Sub_metering_2,
             ylim=range(c(data2$Sub_metering_1, data2$Sub_metering_2, data2$Sub_metering_3)),
             bty="n", col="red", type="l", xlab=NA, ylab=NA, xaxt="n", yaxt="n")
        par(new = TRUE)
        plot(data2$Time, data2$Sub_metering_3,
             ylim=range(c(data2$Sub_metering_1, data2$Sub_metering_2, data2$Sub_metering_3)),
             col="blue", type="l", xlab=NA, ylab="Energy sub metering",
             cex.axis=0.75, tck=-0.03, cex.lab=0.75)
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty="n", lty=c(1,1), col=c("black", "red", "blue"), cex=0.75) 
       
        ## Bottom right plot
        plot(data2$Time, data2$Global_reactive_power, type = "l", cex.axis=0.75,
             xlab="datetime", tck=-0.03,
             ylab="Global_reactive_power", cex.lab=0.75)     
})

## Creation of PNG file
dev.copy(png, file = "plot4.png", width=480, height=480)  
dev.off()