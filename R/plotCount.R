#' Plot count data
#'
#' Create a bar plot of count data in a data.frame.
#'
#' The argument to this function is expected to be a data.frame with two
#' columns: the first column is a list of unique values, the second column
#' is a list of integers representing count data for the first column.
#'
#' This function is meant to be called with the result of \code{\link{dfCount}},
#' though any data.frame with a proper structure will also work.
#'
#' @param x A data.frame. See 'Details' for more information.
#' @return A ggplot2 layer that can be added to an existing ggplot2 object.
#' @note The \code{ggplot2} package is required for these functions.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   if (requireNamespace("nycflights13", quietly = TRUE)) {
#'     flights <- nycflights13::flights
#'     df <- dfCount(flights, "origin")
#'     plotCount(df)
#'   }
#'
#'   plotCount(dfCount(infert, "education", sort = FALSE))
#'   plotCount(table(infert$education))
#' }
#' @seealso \code{\link{dfCount}}
plotCount <- function(x) {
	rsaladRequire("ggplot2")

	# Convert the input to a data.frame, in case it was a table or a tbl_df
	x <- data.frame(x)

	stopifnot(
		ncol(x) == 2,
		is.integer(x[, 2]),
		length(x[, 1]) == length(unique(x[, 1]))
	)

	p <-
		ggplot2::ggplot(x) +
		ggplot2::aes_string(colnames(x)[1], colnames(x)[2]) +
		ggplot2::geom_bar(stat = "identity")

	p
}
