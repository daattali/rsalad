#' Factorize data.frame
#'
#' Convert character columns in a data.frame to factors.
#'
#' Given a data.frame, convert character columns to factors.  By default,
#' all character columns are converted, but the user can specify which columns
#' to convert or to not convert.
#'
#' @note If any of the names in \code{only} or \code{ignore} are not valid
#'   columns, an error is raised.
#' @note Only one of \code{only} or \code{ignore} can be used in a single call.
#' @param df A data.frame.
#' @param only A vector of column names. Only convert these columns to factors.
#' @param ignore A vector of column names. Do not convert these columns.
#' @return A data.frame with all character columns (or only a subset of them
#'   if the parameters were set) converted to factors.
#' @export
#' @examples
#' df <- data.frame(a = 1:3, b = letters[1:3], c = LETTERS[1:3],
#'                  stringsAsFactors = FALSE)
#' str(df)
#' str(dfFactorize(df))
#' str(dfFactorize(df, only = "b"))
#' str(dfFactorize(df, ignore = "b"))
#' str(dfFactorize(df, ignore = c("b", "c")))
#' str(dfFactorize(df, only = c("a")))
#'
#' # The following examples result in errors
#' \dontrun{str(dfFactorize(df, only = c("z")))}
#' \dontrun{str(dfFactorize(df, only = "b", ignore = "c"))}
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
