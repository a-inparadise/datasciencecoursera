rankall <- function(outcome, num = "best") {
  # read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # check outcome
  if (tolower(outcome) != "heart attack" & tolower(outcome) != "heart failure" & tolower(outcome) != "pneumonia") {
    stop("invalid outcome")
  }
  
  rankings <- date.frame()
  
  # loop through the states
  for (state in unique(data$State)) {
    # filter by state
    stateData <- data[data$State==state,]
    
    # validate the num ranking arg
    if (is.numeric(num)) {
      index <- num
      if (index > length(stateData[,1])) {
        NA
      }
    } else {
      if (num == "best") {
        index <- 1
      } else if (num == "worst") {
        index <- length(stateData[,1])
      } else {
        NA
      }
    }
    
    # select by outcome
    if (tolower(outcome) == "heart attack") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        index <- index - numNAs
      }
      stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name),]$Hospital.Name[index]
    } else if (tolower(outcome) == "heart failure") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        index <- index - numNAs
      }
      stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name),]$Hospital.Name[index]
    } else if (tolower(outcome) == "pneumonia") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        index <- index - numNAs
      }
      stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name),]$Hospital.Name[index]
    }
  }
}
