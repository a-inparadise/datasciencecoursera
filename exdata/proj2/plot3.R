library(ggplot2)

# read in data set
NEI <- readRDS("summarySCC_PM25.rds")

# subset data for balitmore
bmore <- NEI[NEI$fips=="24510",]

# factorize the year for nicer x axis
bmore$year <- factor(bmore$year)

# open png stream
png("plot3.png", width=960, height=960, units="px")

# show the trend over each year for each type
g <- ggplot(data=bmore, aes(x=year, y=Emissions))
g <- g + geom_bar(stat="identity")
g <- g + facet_wrap(~ type)
g <- g + labs(title="Total Emissions for Baltimore City by Type")
g <- g + labs(x="Year")
g <- g + labs(y="PM2.5 Emitted (tons)")

print(g)

# close the stream
dev.off()