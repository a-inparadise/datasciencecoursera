README
========================================================

Run Analysis Script - Data Science, Getting and Cleaning Data


The following document is a process description for the creation of the run_analysis.R script.  The run_analysis script leverages the data from the Human Activity Recognition Using Smartphones Dataset (HARUSD), descirbed at the below link, to create a tidy dataset that combines both the test and training data for all mean and standard deviation features and the corresponding subjects, activity ids and labels.  The script also creates a smaller tidy dataset which contains the averages for all features for each activtiy and subject.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The process description for run_analysis.R is as follows.  The script uses the unzipped root of the HARUSD as it's current working directory.  

MERGING X TRAIN AND TEST DATA

It begins by first consuming the X train and test data files.  Next, it consumes the features data file, which lists the column names for each column of data in the X train and test sets.  The assignment called for the extraction of only the mean and standard deviation for each feature, thus the script strips only the mean and std columns from the features file and uses the subset of the feature data to subset the X train and test data sets.  It then merges the two sets train, on top of test using an rbind().  It then applies the column names (which have been tidied, by removing all "-", "(", ")" characters and applying lowercase). 


MERGING SUBJECT TRAIN AND TEST DATA

The subject data files are then read and merged, train on top of test.  A descriptive column name of "subjectid" is applied to the dataframe.   Next, the subjectid data is binded to the larger tidy dataset using a cbind.


MERGING Y TRAIN AND TEST DATA

The next data to fold into the larger tidy data set is the corresponding activity ids, contained in the Y train and test data files.  The script reads in the data and then merges them, train on top of test, and then applies a descriptive label of "activityid" to the data frame.  Next, the activityid data is binded to the larger tidy dataset using a cbind.


APPLYING ACTIVITY LABELS TO ACTIVITY IDS

The activity labels are read into the script and the script creates a new column onto the larger tidy dataset called "activtiylabel", which will contain the activity label for each activity id.  Next, the script loops over each activity label and using the activity id (column 1 of the activity label data) it subsets the large tidy data set and sets the appropriate activity label for each activity id.  Once the loop is complete, the large tidy dataset will contain activity labels for each activity id.


LARGE TIDY DATASET

At this point the script has created a larger tidy dataset that contains all mean and standard deviation features, the subjectid, the activitiyid and the corresponding activity label.  Descriptive column names have been applied to all columns and this is the dataset that the run_analysis script will return.  Note, I've chosen to keep the activityid in the large tidy dataset, this is so that the dataset could be cross referenced with the original data to test for correctness, just in case.


CREATING THE AVERAGE SUMMARY TIDY DATA SET

Using the larger tidy dataset the script uses the aggregate function to create a smaller tidy dataset that contains the average (using the mean function) for each feature for each activity and each subject.  Once the script creates the dataset it nexts creates new column names for each feature that describe them as an average, by simply prepend "avg" to each column name, thus "tbodyaccmeanx" becomes "avgtbodyaccmeanx".  This smaller tidy dataset is then written to file using write.table into the "tidy_analysis.txt" file in the current working directory.
