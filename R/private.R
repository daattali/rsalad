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
rsaladRequire <- function(pkg) {
	if (!requireNamespace(pkg, quietly = TRUE)) {
		stop(paste0(pkg, " required for this function to work. Please install it."),
				 call. = FALSE)
	}
}
