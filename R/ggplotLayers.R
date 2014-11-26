#' Useful ggplot2 layers
#'
#' A small set of useful layers to add to ggplot2 plots.
#'
#' \code{removeGrid} always removes the minor gridlines from the plot, and
#' removes the major gridlines from X and/or Y axis (both by default).
#'
#' \code{removeGridX} is a shortcut for \code{removeGrid(x = TRUE, y = FALSE)}
#'
#' \code{removeGridY} is a shortcut for \code{removeGrid(x = FALSE, y = TRUE)}
#'
#' \code{rotateTextX} causes the labels on the x axis to be rotated 90 degrees
#' so that they are vertical.  This can be useful when there are many labels
#' along the x axis and having them horizontal causes them to overlap.
#'
#' @param x Whether to apply th layer to the X axis.
#' @param y Whether to apply th layer to the Y axis.
#' @return A ggplot2 layer that can be added to an existing ggplot2 object.
#' @note The \code{ggplot2} package is required for these functions.
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   df <- data.frame(x = 1:50, y = 1:50)
#'   p <- ggplot2::ggplot(df, ggplot2::aes(x, y)) + ggplot2::geom_point()
#'   p + removeGrid()
#'   p + removeGrid(y = FALSE)
#'   p + removeGridX()
#'
#'   df <- data.frame(x = paste("letter", LETTERS, sep = "_"),
#'                    y = seq(length(LETTERS)))
#'   p <- ggplot2::ggplot(df, ggplot2::aes(x, y)) + ggplot2::geom_point()
#'   p + rotateTextX()
#' }
#' @name ggplotLayers
NULL

#' @export
#' @rdname ggplotLayers
removeGrid <- function(x = TRUE, y = TRUE) {
	rsaladRequire("ggplot2")

	p <- ggplot2::theme(panel.grid.minor = ggplot2::element_blank())
	if (x) {
		p <- p +
			ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
	}
	if (y) {
		p <- p +
			ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
	}

	p
}

#' @export
#' @rdname ggplotLayers
removeGridX <- function() {
	removeGrid(x = TRUE, y = FALSE)
}

#' @export
#' @rdname ggplotLayers
removeGridY <- function() {
	removeGrid(x = FALSE, y = TRUE)
}

#' @export
#' @rdname ggplotLayers
rotateTextX <- function() {
	if (!requireNamespace("ggplot2", quietly = TRUE)) {
		stop("`ggplot2` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

	ggplot2::theme(
		axis.text.x = ggplot2::element_text(angle = 90, hjust = 1, vjust = 0.5)
	)
}
