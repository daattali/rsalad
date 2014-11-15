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

	ggplot(df, aes_string(colnames(df)[1], colnames(df)[2])) +
		geom_bar(stat = "identity")
}
