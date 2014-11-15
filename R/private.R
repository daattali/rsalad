is.bool <- function(x) {
	is.logical(x) && length(x) == 1 && !is.na(x)
}

is.string <- function(x) {
	is.character(x) && length(x) == 1
}

dotsToChar <- function(...) {
	as.character(substitute(list(...)))[-1L]
}
