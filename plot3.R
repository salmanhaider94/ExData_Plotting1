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


with(dataset1, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
