#' @export
dfCount <- function(df, col, sort = TRUE, name = "total") {
	# Check parameters
	stopifnot(
		is.data.frame(df),
		length(col) == 1,
		col %in% colnames(df),
		is.bool(sort)
	)

	df <-
		df %>%
		dplyr::group_by_(col) %>%
		dplyr::summarise(total = n()) %>%
		dplyr::ungroup()

	if (sort) {
		df <-
			df %>%
			dplyr::arrange(desc(total))
		df[, 1] <- factor(dplyr::first(df), dplyr::first(df))
	}

	colnames(df)[2] <- name

	df
}

#
# dfCount(nycflights13::flights, "dest")
# dfCount(nycflights13::flights, "dest", sort = FALSE)
# dfCount_(nycflights13::flights, dest)
#
# str((dfCount(nycflights13::flights, "dest") %>% head)

# performs mcuh better than table() (which still needs to be converted to data.frame and arranged) when there are many possible values. using "nycflights13::flights" dataset, counting carriers or cities is not that much faster (but still faster), but counting distance for example is much faster
# note: the only visible difernce i can tell so far isthat table() doesnt count NA and I do
# m <- microbenchmark( a(flights, "dep_time"), (table(flights$dep_time)), times=3)
