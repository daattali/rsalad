#' @export
setDefaultParams <- function(params) {
  params <- as.list(params)
  env <- parent.frame()

  invisible(
    lapply(names(params), function(key) {
      if (!exists(key, envir = env, inherits = FALSE)) {
        assign(key, params[[key]], envir = env, inherits = FALSE)
      }
    })
  )
}

a<-function(){
  x <- 10
  print(ls.str())
  setDefaultParams(c("bbA"="n"))
  print("after")
  print(ls.str())
}
a()
