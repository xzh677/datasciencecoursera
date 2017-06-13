pollutantmean <- function(directory, pollutant, id = 1:332) {
	results <- lapply(id, function(x) {
		path <- sprintf("%s/%03d.csv", directory, x);
		data <- read.csv(path);
		data <- data[[pollutant]];
		data <- data[!is.na(data)];
		c(sum(data), length(data))
	});
	
	total = 0;
	count = 0;
	for (x in results) {
		total <- total + x[1];
		count <- count + x[2];
	}
	total / count;
}