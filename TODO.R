vignette

version = 0.0.1


#' dfCount(nycflights13::flights, "dest")
#' dfCount(nycflights13::flights, "dest", sort = FALSE)
#' dfCount(nycflights13::flights, "dest", name = "flights")
#'
#' # Using fake large dataset
#' df <- data.frame(a = rep(1:50, 100000))
#' dfCount(df, "a")



README


devtools:build_vignettes()
browseVignettes(package="rsalad")
