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

#Plot2
#my sistem is in Spanish, so I change the local language to English
Sys.setlocale("LC_TIME", "English")

plot(epc$datetime,
     epc$Global_active_power,type="n",
     ylab="Global Active Power (kilowatts)",
     xlab=""
     )
lines(epc$datetime,epc$Global_active_power)
    
dev.copy(device =png, "plot2.png")
dev.off()
