library("tidyverse")

# import data
data_raw <- read.delim("./data/household_power_consumption.txt", 
		       sep = ";",
		       na.strings = c("?"),
		       colClasses=c(rep("character", 2), rep("numeric", 7)))
# fomrat date and time columns and 
# extract the two relevant days
dates_to_use <- dmy(c("01/02/2007", "02/02/2007"))
data <- data_raw %>% mutate(Date = dmy(Date)) %>% 
	mutate(Time = hms(Time)) %>% 
	filter(Date %in% dates_to_use) %>% 
	mutate(DateTime = Date + Time)

# setlocal to get output for the xlabel in English
Sys.setlocale("LC_TIME", "English")

# open png device
png("plot4.png")

par(mfrow = c(2,2))
# create plot 1
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# create plot 2
plot(data$DateTime, data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# create plot 3
plot(data$DateTime, data$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, 
      col = "red")
lines(data$DateTime, data$Sub_metering_3, 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = c(1,1,1),
       bty = "n")

# create plot 4
plot(data$DateTime, data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# close device
dev.off()
