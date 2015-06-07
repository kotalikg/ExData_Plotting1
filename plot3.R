

###3. Plot

#Read data
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), nrows = 5)
classes <- sapply(tab5rows, class)
hhpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = classes)

#Subset
day1 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01"), select = Date:Sub_metering_3)
day2 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"), select = Date:Sub_metering_3)
plotbase <- rbind(day1, day2)

#Transform Date/Time
plotbase$Date <- as.Date(plotbase$Date, "%d/%m/%Y")
Sys.setlocale("LC_TIME", "C")
plotbase$Time <- as.POSIXct(paste(plotbase$Date, plotbase$Time), "%Y-%m-%d %H:%M:%S", tz = "UTC")

#Plot in PNG file
png("plot3.png", width = 480, height = 480, bg = "transparent")
with(plotbase, plot(Sub_metering_1 ~ Time, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
lines(plotbase$Time, plotbase$Sub_metering_2, type = "l", col = "red")
lines(plotbase$Time, plotbase$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","blue","red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()
