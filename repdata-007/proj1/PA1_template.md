## Reproducible Research - Peer Assessment 1

### Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a Fitbit, Nike Fuelband, or Jawbone Up. These type of devices are part of the “quantified self” movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

### Required packages


```r
library(ggplot2)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

### Loading and preprocessing the data


```r
activity <- read.csv("activity.csv")

activity$steps <- as.numeric(activity$steps)

head(activity)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

### What is mean total number of steps taken per day?

1) Make a histogram of the total number of steps taken each day


```r
ggplot(data=na.omit(activity), aes(x=date, y=steps, fill=date)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=-90)) +
  theme(legend.position="none") +
  labs(title="Total number of steps per day") +
  labs(x="Day") +
  labs(y="Number of steps")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

2) Calculate and report the mean and median total number of steps taken per day


```r
# using library(dplyr)

na.omit(activity) %>%
  group_by(date) %>%
  summarise_each(funs(mean, median), steps)
```

```
## Source: local data frame [53 x 3]
## 
##          date    mean median
## 1  2012-10-02  0.4375      0
## 2  2012-10-03 39.4167      0
## 3  2012-10-04 42.0694      0
## 4  2012-10-05 46.1597      0
## 5  2012-10-06 53.5417      0
## 6  2012-10-07 38.2465      0
## 7  2012-10-09 44.4826      0
## 8  2012-10-10 34.3750      0
## 9  2012-10-11 35.7778      0
## 10 2012-10-12 60.3542      0
## 11 2012-10-13 43.1458      0
## 12 2012-10-14 52.4236      0
## 13 2012-10-15 35.2049      0
## 14 2012-10-16 52.3750      0
## 15 2012-10-17 46.7083      0
## 16 2012-10-18 34.9167      0
## 17 2012-10-19 41.0729      0
## 18 2012-10-20 36.0938      0
## 19 2012-10-21 30.6285      0
## 20 2012-10-22 46.7361      0
## 21 2012-10-23 30.9653      0
## 22 2012-10-24 29.0104      0
## 23 2012-10-25  8.6528      0
## 24 2012-10-26 23.5347      0
## 25 2012-10-27 35.1354      0
## 26 2012-10-28 39.7847      0
## 27 2012-10-29 17.4236      0
## 28 2012-10-30 34.0938      0
## 29 2012-10-31 53.5208      0
## 30 2012-11-02 36.8056      0
## 31 2012-11-03 36.7049      0
## 32 2012-11-05 36.2465      0
## 33 2012-11-06 28.9375      0
## 34 2012-11-07 44.7326      0
## 35 2012-11-08 11.1771      0
## 36 2012-11-11 43.7778      0
## 37 2012-11-12 37.3785      0
## 38 2012-11-13 25.4722      0
## 39 2012-11-15  0.1424      0
## 40 2012-11-16 18.8924      0
## 41 2012-11-17 49.7882      0
## 42 2012-11-18 52.4653      0
## 43 2012-11-19 30.6979      0
## 44 2012-11-20 15.5278      0
## 45 2012-11-21 44.3993      0
## 46 2012-11-22 70.9271      0
## 47 2012-11-23 73.5903      0
## 48 2012-11-24 50.2708      0
## 49 2012-11-25 41.0903      0
## 50 2012-11-26 38.7569      0
## 51 2012-11-27 47.3819      0
## 52 2012-11-28 35.3576      0
## 53 2012-11-29 24.4688      0
```

### What is the average daily activity pattern?

1) Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
# using library(dplyr)

# calculate the average number of steps for all days for each interval
intervalMeans <- na.omit(activity) %>%
  group_by(interval) %>%
  summarise_each(funs(mean), steps)

ggplot(intervalMeans, aes(x=interval, y=steps)) + 
  geom_line() +
  xlab("Intervals") + 
  ylab("Average Steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

2) Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
intervalMeans[which.max(intervalMeans$steps),]
```

```
## Source: local data frame [1 x 2]
## 
##   interval steps
## 1      835 206.2
```

### Imputing missing values

1) Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
nrow(activity[is.na(activity$steps),])
```

```
## [1] 2304
```

2) Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

3) Create a new dataset that is equal to the original dataset but with the missing data filled in.



```r
activityNARep <- activity

# loop through the data set looking for NAs, when one is found,
# replace it with the average steps across all days for that rows interval
# not sophisticated, not quick, but it works

for (i in 1:nrow(activityNARep)) {
  if (is.na(activityNARep[i,]$steps)) {
    interval <- activityNARep[i,]$interval
    activityNARep[i,]$steps <- mean(activityNARep[activityNARep$interval==interval, ]$steps, na.rm=TRUE)
  }
}

head(activityNARep)
```

```
##     steps       date interval
## 1 1.71698 2012-10-01        0
## 2 0.33962 2012-10-01        5
## 3 0.13208 2012-10-01       10
## 4 0.15094 2012-10-01       15
## 5 0.07547 2012-10-01       20
## 6 2.09434 2012-10-01       25
```

4a) Make a histogram of the total number of steps taken each day.


```r
ggplot(data=na.omit(activityNARep), aes(x=date, y=steps, fill=date)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=-90)) +
  theme(legend.position="none") +
  labs(title="Total number of steps per day") +
  labs(x="Day") +
  labs(y="Number of steps")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

4b) Calculate and report the mean and median total number of steps taken per day.


```r
# using library(dplyr)

activityNARep %>%
  group_by(date) %>%
  summarise_each(funs(mean, median), steps)
```

```
## Source: local data frame [61 x 3]
## 
##          date    mean median
## 1  2012-10-01 37.3826  34.11
## 2  2012-10-02  0.4375   0.00
## 3  2012-10-03 39.4167   0.00
## 4  2012-10-04 42.0694   0.00
## 5  2012-10-05 46.1597   0.00
## 6  2012-10-06 53.5417   0.00
## 7  2012-10-07 38.2465   0.00
## 8  2012-10-08 37.3826  34.11
## 9  2012-10-09 44.4826   0.00
## 10 2012-10-10 34.3750   0.00
## 11 2012-10-11 35.7778   0.00
## 12 2012-10-12 60.3542   0.00
## 13 2012-10-13 43.1458   0.00
## 14 2012-10-14 52.4236   0.00
## 15 2012-10-15 35.2049   0.00
## 16 2012-10-16 52.3750   0.00
## 17 2012-10-17 46.7083   0.00
## 18 2012-10-18 34.9167   0.00
## 19 2012-10-19 41.0729   0.00
## 20 2012-10-20 36.0938   0.00
## 21 2012-10-21 30.6285   0.00
## 22 2012-10-22 46.7361   0.00
## 23 2012-10-23 30.9653   0.00
## 24 2012-10-24 29.0104   0.00
## 25 2012-10-25  8.6528   0.00
## 26 2012-10-26 23.5347   0.00
## 27 2012-10-27 35.1354   0.00
## 28 2012-10-28 39.7847   0.00
## 29 2012-10-29 17.4236   0.00
## 30 2012-10-30 34.0938   0.00
## 31 2012-10-31 53.5208   0.00
## 32 2012-11-01 37.3826  34.11
## 33 2012-11-02 36.8056   0.00
## 34 2012-11-03 36.7049   0.00
## 35 2012-11-04 37.3826  34.11
## 36 2012-11-05 36.2465   0.00
## 37 2012-11-06 28.9375   0.00
## 38 2012-11-07 44.7326   0.00
## 39 2012-11-08 11.1771   0.00
## 40 2012-11-09 37.3826  34.11
## 41 2012-11-10 37.3826  34.11
## 42 2012-11-11 43.7778   0.00
## 43 2012-11-12 37.3785   0.00
## 44 2012-11-13 25.4722   0.00
## 45 2012-11-14 37.3826  34.11
## 46 2012-11-15  0.1424   0.00
## 47 2012-11-16 18.8924   0.00
## 48 2012-11-17 49.7882   0.00
## 49 2012-11-18 52.4653   0.00
## 50 2012-11-19 30.6979   0.00
## 51 2012-11-20 15.5278   0.00
## 52 2012-11-21 44.3993   0.00
## 53 2012-11-22 70.9271   0.00
## 54 2012-11-23 73.5903   0.00
## 55 2012-11-24 50.2708   0.00
## 56 2012-11-25 41.0903   0.00
## 57 2012-11-26 38.7569   0.00
## 58 2012-11-27 47.3819   0.00
## 59 2012-11-28 35.3576   0.00
## 60 2012-11-29 24.4688   0.00
## 61 2012-11-30 37.3826  34.11
```

4c) Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

The values differ from the original data, in that dates that were previously missing due to NAs are now present, creating a more complete data set.

### Are there differences in activity patterns between weekdays and weekends?

1) Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.


```r
# cast the date as a date
activity$date <- as.Date(activity$date, format="%Y-%m-%d")

# create new column for daytype factor
activity$daytype <- NA

# go through the dataset and determine the daytype for each date
for (i in 1:nrow(activity)) {
  if (weekdays(activity[i,]$date) == "Saturday" || weekdays(activity[i,]$date) == "Sunday") {
    activity[i,]$daytype <- "weekend"
  } else {
    activity[i,]$daytype <- "weekday"
  }
}

# factorize the daytime
activity$daytype <- factor(activity$daytype,levels=c("weekday","weekend"))

head(activity)
```

```
##   steps       date interval daytype
## 1    NA 2012-10-01        0 weekday
## 2    NA 2012-10-01        5 weekday
## 3    NA 2012-10-01       10 weekday
## 4    NA 2012-10-01       15 weekday
## 5    NA 2012-10-01       20 weekday
## 6    NA 2012-10-01       25 weekday
```

2) Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).


```r
# calculate the average number of steps for all days for each interval
intervalDayTypeMeans <- na.omit(activity) %>%
  group_by(interval, daytype) %>%
  summarise_each(funs(mean), steps)

ggplot(intervalDayTypeMeans, aes(x=interval, y=steps)) + 
  geom_line(aes(color=daytype)) +
  facet_wrap(~ daytype) +
  xlab("Intervals") + 
  ylab("Average Steps")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 
