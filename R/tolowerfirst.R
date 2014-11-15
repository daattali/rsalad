#' @export
tolowerfirst <- function(x) {
	stopifnot(is.character(x))
	paste0(tolower(substring(x, 1, 1)), substring(x, 2))
}

# tolowerfirst("CamelCase")
# tolowerfirst("ALLCAPS")
# tolowerfirst(c("First", "_Second"))
