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
hpcDat[,"Date"] <- as.Date(hpcDat[, "Date"], "%d/%m/%Y")
hpcDat[,"Time"] <- strptime(hpcDat[, "Time"], "%H:%M:%S", tz = "GMT")

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

png("plot1.png", width=480, height=480)
hist(
  hpcDat[, "Global_active_power"],
  main ="Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  col = "red",
)
dev.off()
