library(ggplot2)

# read in data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create a subset for all instances of combustion followed by coal
# on the EI.Sector column of the SCC data set
# Note: as discussed in the discussion threads there are MANY aproaches
#       to this aggregation.  in the real world the analysis would have 
#       a well defined scope as well as subject matter experts to define
#       that scope.  since we have neither in this assignment, this is
#       aggregation that i chose.  c'est la vie
coalsccsubset <- subset(SCC, grepl("comb.*coal", EI.Sector, ignore.case=TRUE))

# subset NEI with the coal subset
coalneisubset <- NEI[NEI$SCC %in% coalsccsubset$SCC,]

# factorize data set year
coalneisubset$year <- factor(coalneisubset$year)

# plot 1: total emissions for coal combustion related sources by year
# this is a nice summary plot that shows the total trend over time
g1 <- ggplot(data=coalneisubset, aes(x=year, y=(Emissions/1000))) +
  geom_bar(stat="identity") +
  labs(title="Total Emissions for Coal Combustion-Related Sources by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (kilotons)")

# open png stream
png("plot4.png", width=480, height=480, units="px")

print(g1)

# close the stream
dev.off()