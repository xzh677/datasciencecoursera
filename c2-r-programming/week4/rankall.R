rankall <- function(outcomeName, num = "best") {
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  hospitalTitle <- "Hospital.Name"
  colName <- sprintf("Hospital.30.Day.Death..Mortality..Rates.from.%s", firstLetterCap(outcomeName))
  
  if (!colName %in% colnames(outcome)) {
    stop("invalid outcome")
  }
  
  states <- unique(outcome$State)
  
  df <- data.frame(hospital = character(0), state = character(0))
  
  for (state in states) {
    stateData <- outcome[outcome$State == state, c(hospitalTitle, colName)]
    stateData[, colName] <- as.numeric(stateData[, colName])
    stateData <- na.omit(stateData)
    s <- stateData[order(stateData[,colName], stateData[, hospitalTitle]), ]
    if (num == "best") {
      rank <- 1
    } else if (num == "worst") {
      rank <- dim(s)[1]
    } else {
      rank <- num
    }
    df <- rbind(df, data.frame("hospital" = s[rank, hospitalTitle], "state" = state))
    
  }
  df[order(df["state"]), ]
}

firstLetterCap <- function(inStr) {
  words <- strsplit(inStr, " ")[[1]]
  newStr <- paste(toupper(substring(words, 1,1)), tolower(substring(words, 2)),
                  sep="", collapse=" ")
  gsub(" ", ".", newStr)
}