filePath <- "household_power_consumption.txt"
data <- read.table(filePath, sep=";", header=T, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?");
data["dateTime"] <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M")
data1to2 <- data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]
png("plot3.png")

par(mar = c(4,4,2,1))

with(data1to2, {
  plot(dateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
  points(dateTime, Sub_metering_2, col="red", type="l")
  points(dateTime, Sub_metering_3, col="blue", type="l")
  legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})


dev.off()
