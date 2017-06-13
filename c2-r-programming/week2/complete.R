complete <- function(directory, id = 1:332) {
	results <- lapply(id, function(x) {
		path <- sprintf("%s/%03d.csv", directory, x);
		data <- read.csv(path);
		sulfate <- data[["sulfate"]];
		nitrate <- data[["nitrate"]];
		idx <- !is.na(sulfate) & !is.na(nitrate);
		c(x, length(idx[idx == T]));
	});
	
	df = data.frame(id=integer(), nobs=integer());
	for (x in results) {
		df = rbind(df, data.frame(id = x[1], nobs = x[2]));
	}
	df;
}