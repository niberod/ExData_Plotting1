library(tidyverse)
library(lubridate)

#load the database
epc<-read_delim('household_power_consumption.txt',delim = ";",
                locale=locale(
                    date_format = "%d/%m/%Y"
                )
) 


#filter the dates 2007-02-01 and 2007-02-02
epc<-epc %>% 
    filter(
        Date==as.Date("2007-02-01") |
            Date==as.Date("2007-02-02")
    ) %>% 
    mutate(datetime=as.POSIXct(paste(Date,Time)))



#my sistem is in Spanish, so I change the local language to English
Sys.setlocale("LC_TIME", "English")


#plot4
windows(width = 8,height = 8)

par(mfrow=c(2,2))

plot(epc$datetime,
     epc$Global_active_power,type="n",
     ylab="Global Active Power",
     xlab=""
)
lines(epc$datetime,epc$Global_active_power)

plot(epc$datetime,
     epc$Voltage,type="n",
     ylab="Voltage",
     xlab="datetime"
)
lines(epc$datetime,epc$Voltage)




plot(epc$datetime,
     epc$Sub_metering_1,type="n",
     ylab="Energy sub metering",
     xlab=""
)
lines(epc$datetime,epc$Sub_metering_1,col="black")
lines(epc$datetime,epc$Sub_metering_2,col="red")
lines(epc$datetime,epc$Sub_metering_3,col="blue")
legend("topright",cex=0.9,bty = "n", lty=1,col=c("black","red","blue"),legend = names(epc[7:9]))

plot(epc$datetime,
     epc$Global_reactive_power,type="n",
     ylab="Global_reactive_power",
     xlab="datetime"
)
lines(epc$datetime,epc$Global_reactive_power)



dev.copy(device =png, "plot4.png")
dev.off()


