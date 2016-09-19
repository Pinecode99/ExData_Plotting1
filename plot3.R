##  plot 3
#
#  preliminaries
library(data.table)
library(lubridate)
library(dplyr)
library(datasets)

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

#create the plot

with(hpc2,{
        plot(datetime,Sub_metering_1, type="s", col="black", xlab="",ylab = "Energy sub metering") +
                points(datetime,Sub_metering_2, type="s", col="red")+
                points(datetime,Sub_metering_3, type="s", col="blue")
        legend("topright",lty=c(1,1),lwd=c(1.5,1.5),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

#legend("topright",lty=c(1,1),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.copy(png,file = "./plot3.png")

dev.cur()
dev.off()
dev.cur()

# end


