# read in data set
NEI <- readRDS("summarySCC_PM25.rds")

# calculate total emmissions for all sources for each year
totals <- tapply(NEI$Emissions, NEI$year, sum)

# convert totals from kilotons to tons
totals <- totals / 1000

# open png stream
png("plot1.png", width=480, height=480, units="px")

# use a bar plot to show the trend over each year
barplot(totals, xlab="Year", ylab="PM2.5 Emitted (tons)", col="blue", main="Total Emissions By Year")

# close the stream
dev.off()