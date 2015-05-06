#' Convert a list of lists to a dataframe
#'
#' @export
list2d_to_df <- function(lol, colname) {
  lol %<>%
    t %>% as.data.frame %>%
    dplyr::mutate_(.dots = setNames(list(~ row.names(.)), colname))
  lol[] <- lapply(lol, unlist)
  lol
}

# vapply(letters[1:3], function(x){list(a=5, b="ff", c=x)}, list(0, "", "")) %>%
# list2d_to_df("lettername")
