library(data.table)

allPlots <-
    function()
    {
        png(
            filename = "plot4.png",
            width = 480,
            height = 480
        )
        
        par(
            mfrow = c(2, 2)
        )
        
        plot1()
        
        plot2()
        
        plot3()
        
        plot4()
        
        dev.off()
    }

plot1 <-
    function()
    {
        data <-
            getData()
                
        
        plot(
            data$DateAndTime,
            data$Global_active_power,
            main = " ", 
            ylab = "Global Active Power (kilowatts)",
            xlab = "",
            type = "l"
        )
    }

plot2 <-
    function()
    {
        data <-
            getData()
        
        
        plot(
            data$DateAndTime,
            data$Voltage,
            main = "", 
            ylab = "Voltage",
            xlab = "datetime",
            type = "l"
        )
    }


plot3 <-
    function()
    {
        data <-
            getData()
        
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
            lty = 1,
            bty = "n"
        )
    }

plot4 <-
    function()
    {
        data <-
            getData()
        
        
        plot(
            data$DateAndTime,
            data$Global_reactive_power,
            main = "", 
            ylab = "Global_reactive_power",
            xlab = "datetime",
            type = "l"
        )
    }

cachedData <-
    NULL

getData <-
    function()
    {
        if (is.null(cachedData))
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
                Global_active_power := as.numeric(Global_active_power)
                ]
            
            data[
                ,
                Global_reactive_power := as.numeric(Global_reactive_power)
                ]
            
            data[
                ,
                Voltage := as.numeric(Voltage)
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
            
            cachedData <<-
                data
        }
        
        cachedData
    }