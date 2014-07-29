pollutantmean <- function(directory, pollutant, id = 1:332) {
  # set working directory
  setwd(directory)
  
  # read in data files in directory
  datafiles <- lapply(dir(), read.csv)
  
  # create empty data frame
  data <- data.frame()
  
  # merge into one data frame
  for (df in datafiles) {
    
    data <- merge(data, df)
  }
  
  data
  
#   # create empty numeric vector
#   v <- numeric()
#   
#   # loop through the specified ids
#   for (i in id) {
#     # append the specified column data to the v vector
#     v <- c(v, data[[i]])
#   }
#   
#   # return the mean, NA's removed
#   mean(v, na.rm=TRUE)
}