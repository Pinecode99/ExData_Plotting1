#  plot2
#
#  preliminaries
library(data.table)
library(lubridate)
library(dplyr)
library(datasets)

rm(hpc)
rm(hpc2)
rm(hpc3)
hpc <- fread("./household_power_consumption.txt", header=TRUE, na.strings=c("?"))
dim(hpc)
head(hpc)


hpc$Date <- dmy(hpc$Date)
head(hpc)
str(hpc)

hpc <- mutate(hpc,Dwk=wday((Date), label=T))
head(hpc)

hpc <- filter(hpc, Date == "2007-02-01"|Date == "2007-02-02")
dim(hpc)

hpc2 <- mutate(hpc, datetime = paste(Date,Time))
head(hpc2)

hpc2$datetime <- ymd_hms(hpc2$datetime)
head(hpc2$datetime)



with(hpc2,plot(datetime,Global_active_power, type="l",xlab="", ylab="Global Active Power (Killowatts)"))

dev.copy(png,file = "./plot2.png")

dev.cur()
dev.off()
dev.cur()

# end
