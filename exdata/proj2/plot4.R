# read in data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create a subset for all instances of combustion followed by coal
# on the Short.Name column of the SCC data set
# Note: as discussed in the discussion threads there are MANY aproaches
#       to this aggregation.  in the real world the analysis would have 
#       a well defined scope as well as subject matter experts to define
#       that scope.  since we have neither in this assignment, this is
#       aggregation that i chose.  c'est la vie
coalsccsubset <- subset(SCC, grepl("comb.*coal", Short.Name, ignore.case=TRUE))

# subset NEI with the coal subset
coalneisubset <- NEI[NEI$SCC %in% coalsccsubset$SCC,]

# calculate total emmissions for coal combustion-related sources for each year
totals <- tapply(coalneisubset$Emissions, coalneisubset$year, sum)

# convert totals to kilotons (nicer y axis)
totals <- totals / 1000

# open png stream
png("plot4.png", width=480, height=480, units="px")

# use a bar plot to show the trend over each year
barplot(totals, xlab="Year", ylab="PM2.5 Emitted (kilotons)", col="blue", main="Total Emissions for Coal Combustion-Related Sources")

# close the stream
dev.off()