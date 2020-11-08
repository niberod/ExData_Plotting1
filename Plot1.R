library(tidyverse)

#load the database
epc<-read_csv2('household_power_consumption.txt',
          locale=locale(
              date_format = "%d/%m/%Y"
          )
) %>% 
    #it loads these variables as characters
    mutate(Global_active_power=as.numeric(Global_active_power),
           Global_reactive_power=as.numeric(Global_reactive_power),
           Voltage=as.numeric(Voltage),
           Global_intensity=as.numeric(Global_intensity),
           Sub_metering_1=as.numeric(Sub_metering_1),
           Sub_metering_2=as.numeric(Sub_metering_2)
          
           )

#filter the dates 2007-02-01 and 2007-02-02
epc<-epc %>% 
    filter(
    Date==as.Date("2007-02-01") |
    Date==as.Date("2007-02-02")
)%>% 
    mutate(datetime=as.POSIXct(paste(Date,Time)))

    
#Plot1
hist(epc$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red"
     )

dev.copy(device =png, "plot1.png")
dev.off()
