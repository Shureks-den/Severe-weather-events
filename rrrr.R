filename<-"WeatherRepData.bz2"
if(!file.exists(filename))
    download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", filename)


data<-read.csv(filename)


EVlist<-split(data, data$EVTYPE)

Fatlist<-EVlist[["FATALITIES"]]


x <- data.frame(ID=1:5,Injures=sort(sapply(split(data$INJURIES, data$EVTYPE), max), decreasing = TRUE)[1:5],
                Fatal=sort(sapply(split(data$FATALITIES, data$EVTYPE), max), decreasing = TRUE)[1:5] )
x$Injures<-sort(sapply(split(data$INJURIES, data$EVTYPE), max), decreasing = TRUE)[1:5]
x$Fatal<-sort(sapply(split(data$FATALITIES, data$EVTYPE), max), decreasing = TRUE)[1:5]


dp<-ggplot(data = x, aes(ID,Injures,Fatal))+geom_line(col="blue")
pd<-ggplot(data = x, aes(ID,Fatal))+geom_line(col="red")


dp+pd

ggarrange(dp,pd, nrow=2, ncol=1)
