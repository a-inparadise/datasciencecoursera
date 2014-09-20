# read in data set
NEI <- readRDS("summarySCC_PM25.rds")

# subset data for balitmore
bmore <- NEI[NEI$fips=="24510",]

# calculate total emmissions for all sources for each year
# for baltimore city, fips == "24510"
totals <- tapply(bmore$Emissions,bmore$type, sum)

# open png stream
png("plot2.png", width=480, height=480, units="px")

# use a bar plot to show the trend over each year
# orange for the orioles :-D
barplot(totals, xlab="Year", ylab="PM2.5 Emitted (tons)", col="orange", main="Total Emissions By Year For Baltimore City")

# close the stream
dev.off()