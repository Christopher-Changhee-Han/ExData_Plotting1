library(dplyr)
library(lubridate)

house <- read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors = FALSE)
patterns <- c("\\b1/2/2007\\b", "\\b2/2/2007\\b")

result <- filter(house, grepl(paste(patterns, collapse="|"), Date))

result$datetime <- dmy_hms(paste(result$Date, result$Time))


par(mfrow=c(1,1))
result$Global_active_power <- as.numeric(result$Global_active_power)

dev.set(3)
png("plot4.png")
par(mfrow= c(2,2))
plot(result$datetime, result$Global_active_power, type = "l", xlab= "", ylab= "Global Active Power")
plot(result$datetime, as.numeric(result$Voltage), type = "l", xlab ="datetime", ylab= "Voltage")
plot(result$datetime, result$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub meeting")
lines(result$datetime, result$Sub_metering_2, type = "l", col= "red")
lines(result$datetime, result$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= 1)
plot(result$datetime, result$Global_reactive_power, xlab= "datetime", type = "l")
dev.off()
