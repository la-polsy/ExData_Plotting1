library(data.table)

# read data
allData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

data <- data.table(allData)
# keep only dates of interest (no need for date conversion here)
data <- data[Date == "1/2/2007" | Date == "2/2/2007"]
# convert to numeric the only column of interest
gap <- as.numeric(data$Global_active_power)
# remove NA
gap <- gap[!is.na(gap)]

png(file = "plot1.png") 

hist(gap, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     border="black", 
     col="red",
     xlim = c(0, 8),
     # don't draw the axis yet
     xaxt="n",
     ylim = c(0, 1200),
     breaks = seq(0, 8, by=.5)
     )
## draw the x-axis afterwards to have a smaller range
axis(side=1, at=c(0, 2, 4, 6))

dev.off()