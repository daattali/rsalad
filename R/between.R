#' Between
#'
#' Determine if a numeric value is between the specified range
#'
#' \code{x \%btwn\% rng} is equivalent to \code{between(x, rng, inclusive = TRUE)}.
#'
#' @param x Numeric vector (or single value): the values to check if they're
#' between \code{rng}.
#' @param rng Two-element numeric cector: the range.
#' @param inclusive Whether or not to include the lower and upper values of
#' the range (default TRUE).
#' @return A logical vector of the same length as \code{x}.
#'
#'   For every element in \code{x}, return \code{TRUE} if the value lies within
#'   \code{rng}, and \code{FALSE} otherwise.
#' @examples
#' 5 %btwn% c(1, 10)
#' c(5, 20) %btwn% c(5, 10)
#' between(5, c(5, 10))
#' between(5, c(5, 10), inclusive = FALSE)
#' @name between
NULL

#' @export
#' @rdname between
"%btwn%" <- function(x, rng) {
  between(x, rng, inclusive = TRUE)
}

#' @export
#' @rdname between
between <- function(x, rng, inclusive = TRUE) {
  stopifnot(is.numeric(x), is.numeric(rng), length(rng) == 2, is.bool(inclusive))
  rng <- sort(rng)
  if (inclusive) {
    x >= rng[1] & x <= rng[2]
  } else {
    x > rng[1] & x < rng[2]
  }
}
