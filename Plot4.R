#downloading and unzipping file from web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data") #unzipping

#Reading SCC and NEI file

SCC <- data.table::as.data.table(x = readRDS(file = "./data/Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "./data/summarySCC_PM25.rds"))


# Subset coal combustion related NEI data
combRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combSCC <- SCC[combRelated & coalRelated, SCC]
combNEI <- NEI[NEI[,SCC] %in% combSCC]

png("plot4.png", width=480,height=480,units="px",bg="transparent")

library(ggplot2)
ggplot(combNEI,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()