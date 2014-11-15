#' @export
dfFactorize <- function(df, only = c(), ignore = c()) {
	# Check parameters
	stopifnot(
		is.data.frame(df),
		length(only) == 0 || length(ignore) == 0,
		all(c(only, ignore) %in% colnames(df))
	)

	# Determine which columns to change
	colsConvert <- rep(TRUE, ncol(df))
	if (length(only) > 0) {
		colsConvert <- colnames(df) %in% only
	}
	if (length(ignore) > 0) {
		colsConvert <- colnames(df) %nin% ignore
	}
	colsConvert <- colsConvert & sapply(df, is.character)

	# Convert specific columns to factors
	df[colsConvert] <- lapply(df[colsConvert], as.factor)

	df
}

# df <- data.frame(a=1:3,b=letters[1:3],c=LETTERS[1:3], stringsAsFactors = F)
# str(dfFactorize(df))
# str(dfFactorize(df, only=c("a"),ignore=c()))
