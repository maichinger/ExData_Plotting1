plot4 <- function() {

  # download file and unzip
  #install.packages("downloader")
  library(downloader)
  library(ggplot2)
  #url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  #download(url, dest="dataset.zip", mode="wb")
  #unzip ("dataset.zip")
  
  # just doing read and subset. later to be optimized by just reading the required rows
  # workaround to get the header right
  colnames<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  #print(colnames)
  mydata<-read.table("household_power_consumption.txt",sep=";",as.is=TRUE,na.strings="?",skip=2,col.names=colnames,header=FALSE)
  
  mydata2<-subset(mydata, Date == "1/2/2007" | Date =="2/2/2007")
  #print(head(mydata2))
  
  #converting date time
  Sys.setlocale("LC_ALL", "English")
  DateTime<-strptime(paste(mydata2$Date,mydata2$Time),format = "%d/%m/%Y %H:%M:%S", tz = "")
  mydata2$DateTime <-DateTime
  #head(mydata2)
  #standard png has already required res 480 by 480

  png("plot4.png")
  par(mfrow=c(2,2))
  #first plot
  plot(DateTime,y = mydata2$Global_active_power,type='l', col="black", xlab = "", ylab = "Global Active Power") 
    #second plot
  plot(DateTime,y = mydata2$Voltage,type='l', xlab = "datetime", ylab = "Voltage")
  #third plot
  plot(DateTime,y = mydata2$Sub_metering_1,type='l', col="black",xlab = "", ylab = "Energy sub metering") 
  lines(mydata2$Sub_metering_2,x=mydata2$DateTime, col = "red")
  lines(mydata2$Sub_metering_3,x=mydata2$DateTime, col = "blue")
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,bty="n")
  #fourth plot
  plot(DateTime,y = mydata2$Global_reactive_power,type='l', xlab = "datetime", ylab = "Global_reactive_power") 
  dev.off()
}

