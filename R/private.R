# This file contains common helper functions used in this package that
# are not exported

# Check if an input is a boolean (either TRUE or FALSE)
is.bool <- function(x) {
  is.logical(x) && length(x) == 1 && !is.na(x)
}

# Check if an input is a string
is.string <- function(x) {
  is.character(x) && length(x) == 1
}

# Convert a ... argument into a character vector
# TODO(daattali) look into the lazyeval package and understand better how
#   non-standard evaluation works
dotsToChar <- function(...) {
  as.character(substitute(list(...)))[-1L]
}

# Check if a required package for a function can be loaded
rsaladRequire <- function(pkgs) {
  invisible(
    lapply(pkgs, function(pkg) {
      if (!requireNamespace(pkg, quietly = TRUE)) {
        stop(sprintf("`%s` package is required for this function to work. Please install it.", pkg),
             call. = FALSE)
      }
    })
  )
}

# Check if a suggested package for a function can be loaded
rsaladSuggest <- function(pkgs) {
  invisible(
    lapply(pkgs, function(pkg) {
      if (!requireNamespace(pkg, quietly = TRUE)) {
        warning(sprintf("`%s` package is recommended for this function to work. Please install it if possible.", pkg),
             call. = FALSE)
      }
    })
  )
}

# Check if a path is a real directory
isDirectoryMock <- function(pathname) {
  pathname <- as.character(pathname)
  fileinfo <- file.info(pathname)
  if (is.na(fileinfo$isdir)) {
    return(FALSE)
  }
  fileinfo$isdir
}
isDirectory <- function(pathname) {
  if (requireNamespace("R.utils", quietly = TRUE)) {
    return(R.utils::isDirectory(pathname))
  }
  isDirectoryMock(pathname)
}

# Check if a path is a real file
isFileMock <- function(pathname) {
  pathname <- as.character(pathname)
  fileinfo <- file.info(pathname)
  if (is.na(fileinfo$isdir)) {
    return(FALSE)
  }
  !(fileinfo$isdir)
}
isFile <- function(pathname) {
  if (requireNamespace("R.utils", quietly = TRUE)) {
    return(R.utils::isFile(pathname))
  }
  isFileMock(pathname)
}

# Check if a path is an absolute path
isAbsolutePathMock <- function(pathname) {
  pathname <- as.character(pathname)
  if (is.na(pathname) | !nzchar(pathname)) {
    return(FALSE)
  }
  if (regexpr("^(~|/|([a-zA-Z]:))", pathname) != -1L) {
    return(TRUE)
  }
  FALSE
}
isAbsolutePath <- function(pathname) {
  if (requireNamespace("R.utils", quietly = TRUE)) {
    return(R.utils::isAbsolutePath(pathname))
  }
  isAbsolutePathMock(pathname)
}
