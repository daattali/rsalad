#' Count number of rows per group
#'
#' Count how many times each distinct value of a data.frame column is
#' observed.
#'
#' \code{dfCount(x, "y")} is similar in functionality to \code{table(x$y)}, but
#' performs better on large datasets (according to my not-so-thorough testing).
#'
#' There are two main differences between \code{dfCount} and \code{table}:
#'
#'   1. \code{dfCount} returns a \code{data.frame} instead of \code{table}
#'      object
#'
#'   2. \code{dfCount} includes a row for number of NA observations, whereas
#'      \code{table} does not by default
#' @note The \code{dplyr} package is required for this function.
#' @section Performance:
#' This function performs much faster than its equivalent \code{table} call on
#' large datasets, even though the \code{table} function does not sort the
#' results. The main speed boost is due to the fact that `dplyr` is used.
#'
#' For example, with the following data.frame
#'
#' \code{df <- data.frame(a = rep(1:50, 100000))}
#'
#' running \code{dfCount(df, "a")} on my machine 50 times is, on average, 10x
#' faster than \code{table(df$a)} (217 milliseconds vs 2112 milliseconds).
#'
#' See the package vignette for more benchmarking analysis.
#' @param df A data.frame.
#' @param col The column to count.
#' @param sort Whether or not to sort the resulting total column.
#' @param name The name of the total column.
#' @return A data.frame with two columns: The first column is the distinct
#'   values of the given variable, the second column shows the total number of
#'   rows with that value.
#' @export
#' @examples
#' if (requireNamespace("nycflights13::", quietly = TRUE)) {
#'   flights <- nycflights13::flights
#'   dfCount(flights, "dest")
#'   dfCount(flights, "dest", sort = FALSE)
#'   dfCount(flights, "dest", name = "flights")
#' }
#'
#' dfCount(infert, "education")
#' dfCount(infert, "education", sort = FALSE)
#' data.frame(table(infert$education))
#' @seealso \code{\link{plotCount}}
dfCount <- function(df, col, sort = TRUE, name = "total") {
	if (!requireNamespace("dplyr", quietly = TRUE)) {
		stop("`dplyr` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

	# Check parameters
	stopifnot(
		is.data.frame(df),
		length(col) == 1,
		col %in% colnames(df),
		is.bool(sort)
	)

	# Count the number of observations per group
	df <-
		df %>%
		dplyr::group_by_(col) %>%
		dplyr::summarise(total = n()) %>%
		dplyr::ungroup()

	# Sort (most observations near the top)
	# TODO(daattali) I really wanted to do everything in a proper NSE way,
	#   but I couldn't figure out how to rename/mutate/arrange using a variable
	#   as the column name
	if (sort) {
		df <-
			df %>%
			dplyr::arrange(desc(total))
		df[, 1] <- factor(dplyr::first(df), dplyr::first(df))
	}

	# Rename the variable
	colnames(df)[2] <- name

	df
}
