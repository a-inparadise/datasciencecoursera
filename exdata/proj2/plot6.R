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
bmoreplusla <- subset(NEI, fips=="24510" | fips=="06037")

# subset bmore and la NEI with the motor vehicle subset
mvbmorela <- bmoreplusla[bmoreplusla$SCC %in% mvsccsubset$SCC,]

# factorize data set year and fips
mvbmorela$year <- factor(mvbmorela$year)
mvbmorela$fips <- factor(mvbmorela$fips)

# relabel the fips levels to the county name for cleaner faceting
levels(mvbmorela$fips)[levels(mvbmorela$fips)=="24510"] <- "Baltimore City"
levels(mvbmorela$fips)[levels(mvbmorela$fips)=="06037"] <- "Los Angeles County"

# total emissions for motor vehicle sources by year
# this is a nice summary plot that shows the total trend over time
g1 <- ggplot(data=mvbmorela, aes(x=year, y=Emissions)) +
  geom_bar(stat="identity") +
  facet_wrap(~ fips, scales = "free") +
  labs(title="Total Emissions for Motor Vehicle Sources in Los Angeles and Baltimore by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (tons)")

# open png stream
png("plot6.png", width=960, height=960, units="px")

print(g1)

# close the stream
dev.off()