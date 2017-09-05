library(data.table)
Sys.setlocale(locale = "USA")

# read data
allData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

data <- data.table(allData)
# keep only dates of interest
data <- data[Date == "1/2/2007" | Date == "2/2/2007"]
# convert date
timestamp <- data[, paste0(Date, " ", Time)]
timestamp <- strptime(timestamp, "%d/%m/%Y %H:%M:%S")
# convert numerics (Sub_metering_3 is already numeric)
numericCols <- c("Sub_metering_1", "Sub_metering_2")
data[, (numericCols) := lapply(.SD, as.numeric), .SDcols = numericCols]

png(file = "plot3.png") 

plot(timestamp, data$Sub_metering_1,
     type = "l", ylab="Energy sub metering", xlab="")
lines(timestamp, data$Sub_metering_2, col = "red")
lines(timestamp, data$Sub_metering_3, col = "blue")
legend("topright", # places a legend at the appropriate place
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black", "red", "blue")) # gives the legend lines the correct color and width

dev.off()