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



#Plot3
#my sistem is in Spanish, so I change the local language to English
Sys.setlocale("LC_TIME", "English")


plot(epc$datetime,
     epc$Sub_metering_1,type="n",
     ylab="Energy sub metering",
     xlab=""
)
lines(epc$datetime,epc$Sub_metering_1,col="black")
lines(epc$datetime,epc$Sub_metering_2,col="red")
lines(epc$datetime,epc$Sub_metering_3,col="blue")
legend("topright",lty=1,cex=0.75,col=c("black","red","blue"),legend = names(epc[7:9]))


dev.copy(device =png, "plot3.png")
dev.off()


