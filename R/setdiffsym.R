#' Symmetric set difference
#'
#' Perform symmetric set difference, as opposed to \code{base::setdiff} which
#' performs asymmetric set difference.
#'
#' @param x,y Vectors
#' @return All elements that are in one vector but not the other
#' @export
#' @examples
#' setdiffsym(1:4, 3:5)
#' setdiffsym(3:5, 1:4)
setdiffsym <- function(x, y) {
	setdiff(union(x, y), intersect(x, y))
}
