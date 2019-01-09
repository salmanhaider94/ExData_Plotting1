dataset<- read.table("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
head(dataset)

# We will only be using data from the dates 2007-02-01 and 2007-02-02 (2 days data) Y_M_D
# converting from D_M_Y - > Y_M_D 

dataset$Date<-as.Date(dataset$Date,"%d/%m/%Y", tryFormats = "%Y-%m-%d")

dataset1<-subset(dataset, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#removing incomplete data
dataset1 <- dataset1[complete.cases(dataset1),]

#original time in format hh:mm:ss
combinedateTime <- paste(dataset1$Date, dataset1$Time)

## Removing the Date and Time column now 
dataset1 <- dataset1[ ,!(names(dataset1) %in% c("Date","Time"))]

dataset1$DateTime <-combinedateTime
#converting 
dataset1$DateTime <- as.POSIXct(dataset1$DateTime)

hist(dataset1$Global_active_power,xlab = "Global Active power(kilowatts)", main="Global Active Power",col="red")
#saving it as png and closing it
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()