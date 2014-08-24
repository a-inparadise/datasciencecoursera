run_analysis <- function() {
  # read in train and test x (feature data) data sets
  x_train <- read.table("./train/X_train.txt")
  x_test <- read.table("./test/X_test.txt")
  
  # read in features
  features <- read.table("features.txt")
  
  # grab all features and their index, that contain mean() or std()
  des_features <- features[grepl(paste(c("mean\\(\\)", "std\\(\\)"),collapse="|"), features[,2]),]
  
  # format column names to something more "tidy"
  # removing all instances of "-", "(", ")"
  # also lowercasing the whole thing
  tidy_feat_col <- tolower(gsub("\\-|\\(|\\)", "", des_features[,2]))
  
  # subset the x_train and x_test data for only means and stds
  x_des_train <- x_train[,des_features[,1]]
  x_des_test <- x_test[,des_features[,1]]
  
  # vertically merge train and test
  tidy_large <- rbind(x_des_train, x_des_test)
  
  # assign column names from the features set
  colnames(tidy_large) <- tidy_feat_col
  
  # read in subjects
  train_sub <- read.table("./train/subject_train.txt")
  test_sub <- read.table("./test/subject_test.txt")
  
  # vertically merge subject train and test
  subjects <- rbind(train_sub, test_sub)
  colnames(subjects) <- c("subjectid")
  
  # append subject column to the tidy_large data set
  tidy_large <- cbind(tidy_large, subjects) 
  
  # read in train and test data sets
  y_train <- read.table("./train/y_train.txt")
  y_test <- read.table("./test/y_test.txt")
  
  # vertically merge train and test
  activity_ids <- rbind(y_train, y_test)
  colnames(activity_ids) <- c("activityid")
  
  # append activity_id column to the tidy_large data set
  tidy_large <- cbind(tidy_large, activity_ids)
  
  # read in activity descriptions
  labels <- read.table("./activity_labels.txt")
  
  # create new column for activity labels
  tidy_large$activitylabel <- NA
  
  # loop through the labels and subset the tidy_large set with the
  # appropriate activity label, per activity id
  for (i in 1:length(labels[,1])) {
    tidy_large[tidy_large$activityid==labels[i,1],]$activitylabel <- as.character(labels[i,2])
  }
  
  # create the smaller tidy data set
  # contains only the average of each feature for each avctivity and subject
  tidy <- aggregate(tidy_large[,1:66], by=list(activitylabel = tidy_large$activitylabel, subjectid = tidy_large$subjectid), mean)
  
  # create descriptive column names for each averaged feature
  # grab the existing column names and prepend avg to them
  tidynames <- names(tidy)
  for (i in 3:length(tidynames)) {
    tidynames[i] <- paste("avg",tidynames[i],sep="")
  }
  colnames(tidy) <- tidynames
  
  # write the tidy data set out to file in the current working directory
  write.table(tidy, "tidy_analysis.txt", row.names=FALSE)
  
  # return the tidy_large set
  tidy_large
}