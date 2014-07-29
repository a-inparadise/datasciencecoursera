corr <- function(directory, threshold = 0) {
  # set working directory
  setwd(directory)
  
  # read in a list of all of the files in the specified directory
  files <- list.files(directory)
  
  # get number of completes
  completes <- complete(directory)
  
  # create empty data frame for correlations
  corrs <- data.frame()
  
  # loop through completes
  for (i in 1:nrow(completes)) {
    # if number of completes is greater than
    # threshold, calculate the correlation
    if (completes[i,]$nobs > threshold) {
      # read in indexed file
      data <- read.csv(files[completes[i,]$id])

      # get correlation and add to the correlations data frame
      corrs <- rbind(corrs, cor(data$nitrate, data$sulfate, use="complete.obs"))
    }
  }
  
  # return correlations
  corrs
}