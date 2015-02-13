library(data.table)

plot1 <-
    function()
    {
        data <-
            getData()
        
        png(
            filename = "plot1.png",
            width = 480,
            height = 480
        )
        
        hist(
            data$Global_active_power, 
            col = "red", 
            main = "Global Active Power", 
            xlab = "Global Active Power (kilowatts)"
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
        
        data[
            ,
            Date := as.Date(Date, format="%d/%m/%Y")
        ]
        
        data <-
            data[
                data$Date == "2007-02-01"
                | data$Date == "2007-02-02",
            ]
        
        data[
            ,
            Global_active_power := as.numeric(Global_active_power)
        ]
        
        data
    }