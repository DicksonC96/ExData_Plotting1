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
plot(data$Time, data$Global_active_power,
     type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#Export out as png
dev.copy(png, "./plot2.png")
dev.off()