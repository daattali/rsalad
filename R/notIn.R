#' @export
"%nin%" <- function(x, y) {
	notIn(x, y)
}

#' @export
notIn <- function(x, y) {
	stopifnot(is.vector(x) && is.vector(y))
	!(x %in% y)
}

# df <- data.frame(a = 1:5, b = 1:5)
# "a" %in% letters
# "a" %nin% letters
# "a" %nin% LETTERS
# c("a", "A") %nin%  letters
# notIn("A", letters)
