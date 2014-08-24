corr <- function(directory, threshold = 0) {
  # set working directory
  cd <- getwd()
  setwd(directory)
  
  # get number of completes
  completes <- complete(directory)
  
  # grab all file data
  files <- lapply(dir(), read.csv)
  
  # create empty data frame for correlations
  corrs <- numeric()
  
  # loop through completes
  for (i in 1:nrow(completes)) {
    # if number of completes is greater than
    # threshold, calculate the correlation
    if (completes[i,]$nobs > threshold) {
      # loop through the files
      for (file in files) {
        # peek at the first line
        r <- head(file, 1)
        
        # see if the ID is within range
        # if so, correlate
        if (r$ID == completes[i,]$id) {
          # get correlation and add to the correlations data frame
          corrs <- c(corrs, cor(file$nitrate, file$sulfate, use="complete.obs"))
        }
      }
    }
  }
  
  setwd(cd)
  # return correlations
  corrs
}