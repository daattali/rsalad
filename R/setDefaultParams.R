#' @export
setDefaultParams <- function(params) {
  params <- as.list(params)
  env <- parent.frame(1)

  invisible(
    lapply(names(params), function(key) {
      if (!exists(key, envir = env, inherits = FALSE)) {
        assign(key, params[[key]], envir = env, inherits = FALSE)
      }
    })
  )
}
