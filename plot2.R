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

gap <- as.numeric(data$Global_active_power)

png(file = "plot2.png") 

plot(timestamp, gap,
     type = "l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()