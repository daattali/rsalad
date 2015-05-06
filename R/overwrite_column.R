#' Overwrite a column in a data.frame based on a matching column in another df
#'
#' @export
overwrite_column <- function(olddf, newdf, cols, bycol = "well") {
  result <- dplyr::left_join(olddf, newdf, by = bycol)

  if (missing(cols)) {
    cols <- setdiff(colnames(olddf), bycol)
  }

  # yes yes, looks are horrible in R, but I couldn't find a better solution
  # to make sure this works on multiple columns at a time
  for (colname in cols) {
    colname_x <- sprintf("%s.x", colname)
    colname_y <- sprintf("%s.y", colname)

    if (all(c(colname_x, colname_y) %in% colnames(result))) {
      result %<>%
        dplyr::mutate_(.dots = setNames(
          list(lazyeval::interp(
            ~ ifelse(is.na(coly), colx, coly),
            colx = as.name(colname_x),
            coly = as.name(colname_y))),
          colname_x)) %>%
        dplyr::rename_(.dots = setNames(colname_x, colname)) %>%
        dplyr::select_(lazyeval::interp(~ -colname, colname = as.name(colname_y)))
    }
  }

  result
}
