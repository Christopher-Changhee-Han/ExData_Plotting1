library(dplyr)
library(lubridate)

house <- read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors = FALSE)
patterns <- c("\\b1/2/2007\\b", "\\b2/2/2007\\b")

result <- filter(house, grepl(paste(patterns, collapse="|"), Date))

result$datetime <- dmy_hms(paste(result$Date, result$Time))


par(mfrow=c(1,1))
result$Global_active_power <- as.numeric(result$Global_active_power)
hist(result$Global_active_power, col= "red", main= "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png")        
dev.off()
