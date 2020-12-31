#Reading data
system.time(read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?"))
file <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Converting data into date and datetime class
library(lubridate)
file$Date <- dmy(file$Date)
library(dplyr)
data <- filter(file, grepl("2007-02-0[12]", Date))
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Initialize global parameter and png device before plotting graphs
png("./plot4.png")
par(mfrow = c(2,2),
    mar = c(4,4,4,2))

#Top-left graph
plot(data$Time, data$Global_active_power,
     type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#Top-right graph
plot(data$Time, data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "voltage")

#bottom-left graph
plot(data$Time, data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$Time, data$Sub_metering_2,
      col = "red")
lines(data$Time, data$Sub_metering_3,
      col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

#Bottom-right graph
plot(data$Time, data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

#Close and save the png
dev.off()
