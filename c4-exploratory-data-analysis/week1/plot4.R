filePath <- "household_power_consumption.txt"
data <- read.table(filePath, sep=";", header=T, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?");
data["dateTime"] <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M")
data1to2 <- data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]
png("plot4.png")

par(mfrow = c(2,2), mar = c(4,4,2,1))
plot(data1to2$dateTime, data1to2$Global_active_power, xlab="", ylab="Global Active Power", type="l")
plot(data1to2$dateTime, data1to2$Voltage, xlab="datetime", ylab="Voltage", type="l")
with(data1to2, {
  plot(dateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
  points(dateTime, Sub_metering_2, col="red", type="l")
  points(dateTime, Sub_metering_3, col="blue", type="l")
  legend("topright", lwd=1, col=c("black", "red", "blue"), bty = "n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
plot(data1to2$dateTime, data1to2$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")


dev.off()

