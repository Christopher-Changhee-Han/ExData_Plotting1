library(dplyr)
library(lubridate)

house <- read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors = FALSE)
patterns <- c("\\b1/2/2007\\b", "\\b2/2/2007\\b")

result <- filter(house, grepl(paste(patterns, collapse="|"), Date))

result$datetime <- dmy_hms(paste(result$Date, result$Time))


result$Global_active_power <- as.numeric(result$Global_active_power)
plot(result$datetime, result$Global_active_power, type = "l", xlab= "", ylab= "Global Active Power")
dev.copy(png, "plot2.png")
dev.off()