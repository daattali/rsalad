#' Convert first character to lower case
#'
#' Given a character vector, convert only the first alphabetical character to
#' lower case.
#'
#' @param x A character vector
#' @return The original character vector with the first character of every
#'   element converted to lower case
#' @export
#' @examples
#' tolowerfirst("CamelCase")
#' tolowerfirst("ALLCAPS")
#' tolowerfirst(c("First", "_Second"))
tolowerfirst <- function(x) {
	stopifnot(is.character(x))
	paste0(tolower(substring(x, 1, 1)), substring(x, 2))
}
