#' Create markdown/HTML reports from R script with no hassle - deprecated
#'
#' This functions has graduated from \code{rsalad} and is now available in
#' the \code{\link[ezknitr]{ezknitr}} package. You can download \code{ezknitr} from
#' \href{http://cran.r-project.org/web/packages/ezknitr/index.html}{CRAN} or
#' \href{https://github.com/daattali/ezknitr}{GitHub}.
#' @param ... ignored
#' @export
spinMyR <- function(...) {
  stop(sprintf("This function is now available in the ezknitr package. Get it from GitHub - %s",
               "https://github.com/daattali/ezknitr"),
       call. = FALSE)
}
