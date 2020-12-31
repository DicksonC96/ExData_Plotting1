#Reading data
system.time(read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?"))
file <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Converting data into date and datetime class
library(lubridate)
file$Date <- dmy(file$Date)
library(dplyr)
data <- filter(file, grepl("2007-02-0[12]", Date))
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Initialize global parameter and plotting line graph
par(mfrow = c(1,1))
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

#Export out as png
dev.copy(png, "./plot3.png")
dev.off()
       