#Reading data
system.time(read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?"))
file <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Converting data into date and datetime class
library(lubridate)
file$Date <- dmy(file$Date)
library(dplyr)
data <- filter(file, grepl("2007-02-0[12]", Date))
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Initialize global parameter and plotting histogram 
par(mfrow = c(1,1))
with(data,
     hist(Global_active_power,
          col = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)", 
          ylab = "Frequency")
      )

#Export out as png
dev.copy(png, "./plot1.png")
dev.off()