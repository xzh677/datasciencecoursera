filePath <- "household_power_consumption.txt"
data <- read.table(filePath, sep=";", header=T, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?");
data["dateTime"] <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M")
data1to2 <- data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]
png("plot2.png")
plot(data1to2$dateTime, data1to2$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()
