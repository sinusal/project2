#downloading and unzipping file from web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data") #unzipping

#Reading SCC and NEI file

SCC <- data.table::as.data.table(x = readRDS(file = "./data/Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "./data/summarySCC_PM25.rds"))

# NEI data by Baltimore
baltimoreNEI <- NEI[fips=="24510",]

png("plot3.png", width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()