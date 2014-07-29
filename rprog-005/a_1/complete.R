complete <- function(directory, id = 1:332) {
  # set working directory
  setwd(directory)
  
  # read in a list of all of the files in the specified directory
  files <- list.files(directory)
  
  # set up empty data frame
  completes <- data.frame(numeric(), numeric())
  
  # loop through the specified ids
  for (i in id) {
    # read in indexed file
    data <- read.csv(files[i])
    
    # bind new row to data frame
    completes <- rbind(completes, c(i, nrow(data[complete.cases(data),])))
  }
  
  # column name it up
  colnames(completes) <- c("id", "nobs")
  
  # return number of complete cases per id
  completes
}