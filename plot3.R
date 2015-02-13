library(data.table)

plot3 <-
    function()
    {
        data <-
            getData()
        
        png(
            filename = "plot3.png",
            width = 480,
            height = 480
        )
        
        plot(
            data$DateAndTime,
            data$Sub_metering_1,
            main = "", 
            ylab = "Energy sub metering",
            xlab = "",
            type = "l"
        )
        
        lines(
            data$DateAndTime,
            data$Sub_metering_2,
            col = "red"
        )
        
        lines(
            data$DateAndTime,
            data$Sub_metering_3,
            col = "blue"
        )
        
        legend(
            "topright",
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            col = c("black", "red", "blue"),
            lty = 1
        )
        
        dev.off()
    }

getData <-
    function()
    {
        
        data <-
            fread(
                "data/household_power_consumption.txt",
                sep = ";",
                na.strings = "?"
            )
        
        data <-
            data[
                data$Date == "1/2/2007"
                | data$Date == "2/2/2007",
            ]
        
        data[
            ,
            DateAndTime := as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")
        ]
        
        data[
            ,
            Sub_metering_1 := as.numeric(Sub_metering_1)
        ]
        
        data[
            ,
            Sub_metering_2 := as.numeric(Sub_metering_2)
        ]
        
        data[
            ,
            Sub_metering_3 := as.numeric(Sub_metering_3)
        ]
        
        data
    }