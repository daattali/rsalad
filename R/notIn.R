#' Not in
#'
#' Determine if values in the first argument don't exist in the second argument.
#'
#' \code{\%nin\%} is the functional inverse of \code{\%in\%}.
#'
#' \code{lhs \%nin\% rhs} is equivalent to \code{notIn(lhs, rhs)}.
#'
#' @param x Vector or NULL: the values to be matched.
#' @param y Vector or NULL: the values to be matched against.
#' @return A logical vector of the same length as \code{x}.
#'
#'   For every element in \code{x}, return \code{FALSE} if the value exists
#'   in \code{y}, and \code{TRUE} otherwise.
#' @examples
#' "a" %nin% letters
#' "a" %nin% LETTERS
#' c("a", "A") %nin% letters
#' notIn("A", letters)
#' @name notIn
NULL

#' @export
#' @rdname notIn
"%nin%" <- function(x, y) {
	notIn(x, y)
}

#' @export
#' @rdname notIn
notIn <- function(x, y) {
	stopifnot((is.vector(x) || is.null(x)) &&
						(is.vector(y) || is.null(y)))
	!(x %in% y)
}
