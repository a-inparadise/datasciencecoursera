complete <- function(directory, id = 1:332) {
  # set working directory
  #setwd(directory)
  
  # grab all file data
  files <- lapply(dir(), read.csv)
  
  # set up empty data frame
  completes <- data.frame(numeric(), numeric())
  
  # loop through the files
  for (file in files) {
    # peek at the first line
    r <- head(file, 1)
    
    # see if the ID is within range
    # if so, add it
    if (length(id[id==r$ID]) > 0) {
      completes <- rbind(completes, c(r$ID, nrow(file[complete.cases(file),])))
    }
  }
  
  # column name it up
  colnames(completes) <- c("id", "nobs")
  
  # return number of complete cases per id
  completes
}