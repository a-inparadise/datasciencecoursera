library(ggplot2)
library(grid)

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

# will be showing 3 plots to analyze the trend for coal combustion sources
# by year

# plot 1: total emissions for coal combustion related sources by year
# this is a nice summary plot that shows the total trend over time
g1 <- ggplot(data=coalneisubset, aes(x=year, y=(Emissions/1000))) +
  geom_bar(stat="identity") +
  labs(title="Total Emissions for Coal Combustion-Related Sources by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (kilotons)")

# plot 2: emissions for coal combustion related sources by year
# histograms for all emission sources over each year
g2 <- ggplot(data=coalneisubset, aes(x=year, y=(Emissions/1000))) +
  geom_bar(stat="identity") +
  facet_wrap(~ SCC) +
  theme(axis.text.x = element_text(angle=90, vjust=1)) +
  labs(title="Emissions for Coal Combustion-Related Sources by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (kilotons)")
  
# plot 3: emissions for coal combustion related sources by year, with a legend
# this is a different way of viewing the data from plot 2.  it is a bit crowded, 
# but one can see a nice distribution over time and if needed,
# one could  use this plot to dig deeper into each source
g3 <- ggplot(coalneisubset, aes(x=year, y=Emissions, colour=SCC)) +
  geom_point(alpha=.5) +
  guides(col=guide_legend(ncol=2)) +
  labs(title="Emissions for Coal Combustion-Related Sources by Year") +
  labs(x="Year") +
  labs(y="PM2.5 Emitted (tons)")

# open png stream
png("plot4.png", width=960, height=2880, units="px")

# code to set up a custom viewport which will allow for
# printing multiple plots into one png
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

print(g1, vp = vplayout(1, 1))
print(g2, vp = vplayout(2, 1))
print(g3, vp = vplayout(3, 1))

# close the stream
dev.off()