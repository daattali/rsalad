vignette

"at least 3 test per function" some function (ggplot) dont have a test


version = 0.1.0


#' dfCount(nycflights13::flights, "dest")
#' dfCount(nycflights13::flights, "dest", sort = FALSE)
#' dfCount(nycflights13::flights, "dest", name = "flights")
#'
#' # Using fake large dataset
#' df <- data.frame(a = rep(1:50, 100000))
#' dfCount(df, "a")
