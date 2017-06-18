best <- function(state, outcomeName) {
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  hospitalTitle <- "Hospital.Name"
  colName <- sprintf("Hospital.30.Day.Death..Mortality..Rates.from.%s", firstLetterCap(outcomeName))
  if (!state %in% unique(outcome$State)) {
    stop("invalid state.")
  }
  if (!colName %in% colnames(outcome)) {
    stop("invalid outcome")
  }
  stateData <- outcome[outcome$State == state, c(hospitalTitle, colName)]
  
  stateData[, colName] <- as.numeric(stateData[, colName])
  stateData <- na.omit(stateData)
  stateData[min(stateData[, colName]) == stateData[, colName], hospitalTitle]
}

firstLetterCap <- function(inStr) {
  words <- strsplit(inStr, " ")[[1]]
  newStr <- paste(toupper(substring(words, 1,1)), tolower(substring(words, 2)),
        sep="", collapse=" ")
  gsub(" ", ".", newStr)
}