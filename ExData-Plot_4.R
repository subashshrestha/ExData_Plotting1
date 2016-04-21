fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

## Download and unzip the dataset:
download.file(fileURL, filename, method="curl")
unzip(filename)

## Load the dataset:
rawDat <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

## Filter the dataset by date
hpcDat <- rawDat[rawDat[, "Date"] %in% c("1/2/2007","2/2/2007") ,]

## Convert columns into their proper types
datetime <- strptime(paste(hpcDat[, "Date"], hpcDat[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S")

numericFields <- c("Global_active_power",
                   "Global_reactive_power",
                   "Voltage",
                   "Global_intensity",
                   "Sub_metering_1",
                   "Sub_metering_2",
                   "Sub_metering_3")
for (fieldName in numericFields) {
  hpcDat[, fieldName] <- as.numeric(hpcDat[, fieldName])
}

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
plot(
  datetime,
  hpcDat[, "Global_active_power"],
  type = "l",
  main ="",
  xlab = "",
  ylab = "Global Active Power",
)
plot(
  datetime,
  hpcDat[, "Voltage"],
  type = "l",
  main = "",
  ylab = "Voltage",
)

plot(
  datetime,
  hpcDat[, "Sub_metering_1"],
  type = "l",
  main = "",
  xlab = "",
  ylab = "Energy sub metering",
)
lines(datetime, hpcDat[, "Sub_metering_2"], col = "red")
lines(datetime, hpcDat[, "Sub_metering_3"], col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
)
plot(
  datetime,
  hpcDat[, "Global_reactive_power"],
  type = "l",
  main = "",
  ylab = "Global_reactive_power",
)

dev.off()
