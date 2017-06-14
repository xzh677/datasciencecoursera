filePath <- "household_power_consumption.txt"
data <- read.table(filePath, sep=";", header=T, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?");
data1to2 <- data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]
png("plot1.png")
hist(data1to2$Global_active_power, col="Red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
