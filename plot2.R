library(data.table)

plot2 <-
    function()
    {
        data <-
            getData()
        
        png(
            filename = "plot2.png",
            width = 480,
            height = 480
        )
        
        plot(
            data$DateAndTime,
            data$Global_active_power,
            main = "", 
            ylab = "Global Active Power (kilowatts)",
            xlab = "",
            type = "l"
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
            Global_active_power := as.numeric(Global_active_power)
        ]
        
        data
    }