#' @export
removeGrid <- function(x = TRUE, y = TRUE) {
	if (!requireNamespace("ggplot2", quietly = TRUE)) {
		stop("`ggplot2` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

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
removeGridX <- function() {
	removeGrid(x = TRUE, y = FALSE)
}

#' @export
removeGridY <- function() {
	removeGrid(x = FALSE, y = TRUE)
}

#' @export
rotateTextX <- function() {
	if (!requireNamespace("ggplot2", quietly = TRUE)) {
		stop("`ggplot2` needed for this function to work. Please install it.",
				 call. = FALSE)
	}

	ggplot2::theme(
		axis.text.x = ggplot2::element_text(angle = 90, hjust = 1, vjust = 0)
	)
}
