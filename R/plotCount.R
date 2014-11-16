#' Plot count data
#'
#' Create a bar plot of count data in a data.frame.
#'
#' @param x A data.frame
#' @return A ggplot2 layer that can be added to an existing ggplot2 object.
#' @note The \code{ggplot2} package is required for these functions.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#' }
#' @seealso \code{\link{dfCount}}
plotCount <- function(x) {
	if (!requireNamespace("ggplot2", quietly = TRUE)) {
		stop("`ggplot2` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

	if (is.table(x)) {
		x <- data.frame(x)
	}
	stopifnot(
		is.data.frame(x),
		ncol(x) == 2,
		is.numeric(df[, 2])
	)

	ggplot2::ggplot(df,
									ggplot2::aes_string(colnames(df)[1], colnames(df)[2])) +
		ggplot2::geom_bar(stat = "identity")
}
