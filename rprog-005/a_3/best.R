best <- function(state, outcome) {
  # read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # check if state exists in data
  # if not, return error
  if (mean(data$State==state) > 0) {
    # filter by state
    stateData <- data[data$State==state,]
    
    # check outcome
    if (tolower(outcome) == "heart attack") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
      head(stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name),]$Hospital.Name, 1)
    } else if (tolower(outcome) == "heart failure") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
      head(stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name),]$Hospital.Name, 1)
    } else if (tolower(outcome) == "pneumonia") {
      suppressWarnings(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
      head(stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name),]$Hospital.Name, 1)
    } else {
      stop("invalid outcome")
    }
  } else {
    stop("invalid state")
  }
}
