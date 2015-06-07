

###1. Plot

#Read data
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), nrows = 5)
classes <- sapply(tab5rows, class)
hhpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = classes)

#Subset
day1 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01"), select = Date:Sub_metering_3)
day2 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"), select = Date:Sub_metering_3)
plotbase <- rbind(day1, day2)

#Plot in PNG file
png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(plotbase$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
