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


#Convert date and time
DateTime <-strptime(paste(DT$Date, DT$Time, sep=" "),"%d/%m/%Y %H:%M:%S")


#Graphics device
png(filename="plot4.png",height=480,width=480,bg="white")
par(mfrow=c(2,2))


#Plots
#Global active power plot
plot(DateTime, DT$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

#Voltage plot
plot(DateTime, DT$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

#Sub metering plot
plot(DateTime, DT$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")

points(DateTime, DT$Sub_metering_1, col="black", type="l")
points(DateTime, DT$Sub_metering_2, col="red", type="l")
points(DateTime, DT$Sub_metering_3, col="blue", type="l")

legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1, lty=1)

#Global reactive power plot
plot(DateTime, DT$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

#Close graphics device
dev.off()