library(dplyr)
library(lubridate)

house <- read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors = FALSE)
patterns <- c("\\b1/2/2007\\b", "\\b2/2/2007\\b")

result <- filter(house, grepl(paste(patterns, collapse="|"), Date))

result$datetime <- dmy_hms(paste(result$Date, result$Time))

result$Global_active_power <- as.numeric(result$Global_active_power)

par(mfrow=c(1,1))
dev.set(3)
png("plot3.png")
plot(result$datetime, result$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub meeting")
lines(result$datetime, result$Sub_metering_2, type = "l", col= "red")
lines(result$datetime, result$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= 1)
dev.copy(png, "plot3.png")
dev.off()