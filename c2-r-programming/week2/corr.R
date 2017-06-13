corr <- function(directory, threshold = 0) {
	completes <- complete(directory);
	completedIDs <- completes[!completes$nobs <= threshold,]$id;
	if (length(completedIDs) <= 0) {
		return(vector("numeric"));
	}
	results <- lapply(completedIDs, function(id) {
		path <- sprintf("%s/%03d.csv", directory, id);
		data <- read.csv(path);
		sulfate <- data[["sulfate"]];
		nitrate <- data[["nitrate"]];
		idx <- !is.na(sulfate) & !is.na(nitrate);
		sulfate <- sulfate[idx];
		nitrate <- nitrate[idx];
		cor(sulfate, nitrate);
	});
	unlist(results);
}
