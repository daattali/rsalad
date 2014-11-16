#' @export
moveFront <- function(df, cols) {
	bindDfEnds(df, cols, 1)
}
#' @export
moveBack <- function(df, cols) {
	bindDfEnds(df, cols, -1)
}

#' @export
moveFront_ <- function(df, ...) {
	moveFront(df, dotsToChar(...))
}

#' @export
moveBack_ <- function(df, ...) {
	moveBack(df, dotsToChar(...))
}


bindDfEnds <- function(df, cols, dir = 1) {
	if (!requireNamespace("dplyr", quietly = TRUE)) {
		stop("`dplyr` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

	stopifnot(
		is.data.frame(df),
		cols %in% colnames(df)
	)

	cbind(
		df %>% dplyr::select(dir * one_of(cols)),
		df %>% dplyr::select(-dir * one_of(cols))
	)
}
#
# df <- data.frame(a=1:3, b = 4:6, c = 7:9, d = 10:12)
# df %>% moveFront("d")
# df %>% moveFront(c("d", "c"))
# df %>% moveFront(c("c", "d"))
# df %>% moveBack("b")
# df %>% moveBack_(a)
# df %>% moveFront_(b, d)
