#downloading and unzipping file from web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data") #unzipping

#Reading SCC and NEI file

SCC <- data.table::as.data.table(x = readRDS(file = "./data/Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "./data/summarySCC_PM25.rds"))

# Aggregate by sum the total emissions by year
aggTotal <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
  (aggTotal$Emissions)/10^6,
  names.arg=aggTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()