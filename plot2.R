

###2. Plot

#Read data
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), nrows = 5)
classes <- sapply(tab5rows, class)
hhpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = classes)

#Subset
day1 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01"), select = Date:Sub_metering_3)
day2 <- subset(hhpower, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"), select = Date:Sub_metering_3)
plotbase <- rbind(day1, day2)

#Transform Date/Time, select columns
plotbase$Date <- as.Date(plotbase$Date, "%d/%m/%Y")
Sys.setlocale("LC_TIME", "C") #local time setting off (to create English day labels)
plotbase$Time <- as.POSIXct(paste(plotbase$Date, plotbase$Time), "%Y-%m-%d %H:%M:%S", tz = "UTC")
plotbase <- plotbase[,c("Time", "Global_active_power")]

#Plot in PNG file
png("plot2.png", width = 480, height = 480, bg = "transparent")
with(plotbase, plot(Global_active_power ~ Time, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
