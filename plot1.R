#  plot1
# 
#  preliminaries
library(data.table)
library(lubridate)
library(dplyr)
library(datasets)

hpc <- fread("./household_power_consumption.txt", header=TRUE, na.strings=c("?"))
head(hpc)
str(hpc)
dim(hpc)

hpc$Date <- dmy(hpc$Date)
str(hpc)

hpc <- mutate(hpc,Dwk=wday((Date), label=T))
head(hpc)

hpc <- filter(hpc, Date == "2007-2-1"|Date == "2007-2-2")

plot1 <- hist(hpc$Global_active_power,col = "red",xlab = "Global Active Power (killowats)", main = "Global Active Power")
#
#print to png file 480 x 480
dev.copy(png,file = "./plot1.png")

dev.cur()
dev.off()
dev.cur()

# end