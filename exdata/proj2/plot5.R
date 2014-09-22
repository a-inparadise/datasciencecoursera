library(ggplot2)

# read in data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create a subset for all motor vehicles. subset all instances of "onroad" for
# the data category in the SCC dataset
# Note: as discussed in the discussion threads there are MANY aproaches
#       to this aggregation.  in the real world the analysis would have 
#       a well defined scope as well as subject matter experts to define
#       that scope.  since we have neither in this assignment, this is
#       aggregation that i chose.  c'est la vie
mvsccsubset <- subset(SCC, grepl("onroad", Data.Category, ignore.case=TRUE))

# subset the NEI dataset for only baltimore city data
bmore <- NEI[NEI$fips=="24510",]

# subset NEI with the motor vehicle subset
mvbmoreneisubset <- bmore[bmore$SCC %in% mvsccsubset$SCC,]

# factorize data set year
mvbmoreneisubset$year <- factor(mvbmoreneisubset$year)

# total emissions for motor vehicle sources by year
# this is a nice summary plot that shows the total trend over time
g1 <- ggplot(data=mvbmoreneisubset, aes(x=year, y=Emissions)) +
  geom_bar(stat="identity") +
  labs(title="Total Emissions for Motor Vehicle Sources in Baltimore by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (tons)")

# open png stream
png("plot5.png", width=480, height=480, units="px")

print(g1)

# close the stream
dev.off()