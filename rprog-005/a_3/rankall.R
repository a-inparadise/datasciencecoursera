rankall <- function(outcome, num = "best") {
  # read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # check outcome
  if (tolower(outcome) != "heart attack" & tolower(outcome) != "heart failure" & tolower(outcome) != "pneumonia") {
    stop("invalid outcome")
  }
  
  # check rank
  if (num != "best" & num != "worst" & !is.numeric(num)) {
    stop("invalid ranking number")
  }
  
  # create empty data frame
  rankings <- data.frame(hospital=character(100), state=character(100), stringsAsFactors=FALSE)
  
  # loop through the states
  i <- 0
  for (state in sort(unique(data$State))) {
    i <- i + 1
    # filter by state
    stateData <- data[data$State==state,]
    
    # validate the num ranking arg
    if (is.numeric(num)) {
      index <- num
      if (index > length(stateData[,1])) {
        rankings$hospital[i] <- NA
        rankings$state[i] <- state
        #rankings <- rbind(rankings, c(NA, state))
        next
      }
    } else {
      if (num == "best") {
        index <- 1
      } else if (num == "worst") {
        index <- length(stateData[,1])
      }
    }
    
    # select by outcome
    if (tolower(outcome) == "heart attack") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        index <- index - numNAs
      }
      hospName <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name),]$Hospital.Name[index]
      rankings$hospital[i] <- hospName
      rankings$state[i] <- state
      #rankings <- rbind(rankings, c(hospName, state))
    } else if (tolower(outcome) == "heart failure") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        index <- index - numNAs
      }
      rankings <- rbind(rankings, c(stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name),]$Hospital.Name[index], state))
    } else if (tolower(outcome) == "pneumonia") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
      if (num == "worst") {
        numNAs <- sum(is.na(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        index <- index - numNAs
      }
      rankings <- rbind(rankings, c(stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name),]$Hospital.Name[index], state))
    }
  }
  
  # return the rankings data frame
  rankings
}
