pollutantmean <- function(directory, pollutant, id = 1:332) {
  # set working directory
  setwd(directory)
  
  # grab all file data
  files <- lapply(dir(), read.csv)
  
  # create empty numeric vector
  v <- numeric()
  
  # loop through the files
  for (file in files) {
    # peek at the first line
    r <- head(file, 1)
    
    # see if the ID is within range
    # if so, add it to the vector
    if (length(id[id==r$ID]) > 0) {
      v <- c(v, file[[pollutant]])
    }
  }
  
  # return the mean, NA's removed
  mean(v, na.rm=TRUE)
}