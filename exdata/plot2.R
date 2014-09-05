# only read in the data that we're lookging for
# Feb 1, 2007 to Feb 2, 2007
data <- read.table("household_power_consumption.txt", sep=";",stringsAsFactors=FALSE, header=TRUE, skip=66636, nrows=2880)

# assign column names
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# combine the date and the time
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# open png stream
png("plot2.png", width = 480, height = 480, units = "px")

# create the line graph
# global active power along they and date time over x
par(mfrow=c(1,1)) # reset plot canvas
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# close the stream
dev.off()