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
png("plot2.png")

# create plot
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# close device
dev.off()
