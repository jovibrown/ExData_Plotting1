#Load data
library(data.table)
if (! file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile="household_power_consumption.zip")
  unzip("household_power_consumption.zip", files="household_power_consumption.txt")
  file.remove("household_power_consumption.zip")
}

#Use fread to quickly read lines lines 66638 - 69517 are February 1, 2007 and February 2, 2007
DT <-fread(input="household_power_consumption.txt", header=TRUE, sep=";", 
  na.strings="?", skip=66636, nrows=2880)


#Set names
setnames(DT, 1:9, c("Date","Time","Global_active_power", "Global_reactive_power",
  "Voltage","Global_intensity", "Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#Graphics device
png(filename="plot1.png",height=480,width=480,bg="white")


#Plot histogram

hist(DT$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
    

#Close graphics device
dev.off()


