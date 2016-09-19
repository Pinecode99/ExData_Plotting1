#  multiple plot
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



#plot

par(mfrow = c(2,2), mar = c(4,4,2,1))

with(hpc2,{
        plot(datetime, hpc$Global_active_power,type="l", col = "black",xlab = "Global Active Power")
        #
        plot(datetime, hpc$Global_active_power,type="l", col = "black",xlab = "datetime", ylab="Voltage") 
        #
        with(hpc2,{
                plot(datetime,Sub_metering_1, type="s", col="black", xlab="",ylab = "Energy sub metering") +
                        points(datetime,Sub_metering_2, type="s", col="red")+
                        points(datetime,Sub_metering_3, type="s", col="blue")
                legend("topright",lty=c(1,1),lwd=c(1.5,1.5),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        })
        #
        plot(datetime, hpc$Global_reactive_power,type="l", col = "black", xlab="datetime",ylab = "Global Reactive Power", main = "")
        
})

#print to png file 480 x 480
dev.copy(png,file = "./plot4.png")

dev.cur()
dev.off()
dev.cur()  

#end