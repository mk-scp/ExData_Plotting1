library("tidyverse")

# import data
data <- read.delim("./data/household_power_consumption.txt", 
		   sep = ";",
		   na.strings = c("?"),
		   colClasses=c(rep("character", 2), rep("numeric", 7)))
# fomrat date and time columns and 
# extract the two relevant days
dates_to_use <- dmy(c("01/02/2007", "02/02/2007"))
data <- data %>% mutate(Date = dmy(Date)) %>% 
	mutate(Time = hms(Time)) %>% 
	filter(Date %in% dates_to_use)

# open png device
png("plot1.png")

# create plot
hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

# close device
dev.off()
