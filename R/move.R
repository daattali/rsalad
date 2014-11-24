#' Move columns to front/back
#'
#' Move specific columns in data.frames to be the first or last columns.
#'
#' \code{moveFront} moves columns to be the first columns in a data.frame,
#' \code{moveBack} moves columns to be the last columns in a data.frame.
#'
#' The order of the columns as passed in the arguments will be the
#' same order that the columns will appear in the resulting data.frame,
#' regardless if the front or back functions are called.
#'
#' \code{moveFront} and \code{moveBack} are the non-standard evaluation (NSE)
#' versions, while \code{moveFront_} and \code{moveBack_} are the standard
#' evaluation (SE) versions.  Look at the examples to see the difference in
#' usage.
#'
#' @note The \code{dplyr} package is required for these functions.
#' @note If any of the column names given are not valid columns, an error
#'   is raised.
#' @param df A data.frame.
#' @param cols A vector of column names to move. Used in SE functions.
#' @param ... Comma separated list of unquoted expressions. Used in NSE
#'   functions.
#' @return A data.frame with the given columns moved either to the beginning
#'   or end of the data.frame.
#' @examples
#' df <- data.frame(a = 1:3, b = 4:6, c = 7:9, d = 10:12)
#' moveFront(df, d)
#' moveFront(df, d, c)
#' moveFront(df, c, d)
#' moveBack(df, b)
#' moveBack_(df, "a")
#' moveFront_(df, c("b", "d"))
#' @name move
NULL

#' @export
#' @rdname move
moveFront <- function(df, ...) {
	moveFront_(df, dotsToChar(...))
}

#' @export
#' @rdname move
moveBack <- function(df, ...) {
	moveBack_(df, dotsToChar(...))
}

#' @export
#' @rdname move
moveFront_ <- function(df, cols) {
	bindDfEnds(df, cols, 1)
}

#' @export
#' @rdname move
moveBack_ <- function(df, cols) {
	bindDfEnds(df, cols, -1)
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

	isTbl <- dplyr::is.tbl(df)

	# Bind together the two parts of the data.frame
	df <-
		cbind(
			df %>% dplyr::select_(~(dir * one_of(cols))),
			df %>% dplyr::select_(~(-dir * one_of(cols)))
		)

	# If the input was a tbl_df, make sure to return that object too
	if (isTbl) {
		df <- dplyr::tbl_df(df)
	}

	df
}
