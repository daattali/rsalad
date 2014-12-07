#' Create markdown/HTML reports from R script with no hassle
#'
#' This function takes a specially formatted R script and converts it to
#' markdown and HTML documents.  Regular R markdown is written after the
#' roxygen comment (\code{#'}), and code chunk options are written after
#' \code{#+}.  All the pain of dealing with working directories and where
#' files are generated is taken care of.
#'
#' If you've ever written tried using \code{knitr::spin} and got frustrated
#' with working directories and where input/output files are, then you'll love
#' \code{spinMyR}! \code{knitr::spin} is great and easy when all you need to do
#' is convert an R script to a markdown/HTML and everything lives in the same
#' directory.  But if you have a real directory structure, this is rarely the
#' case, and \code{spinMyR} is the solution.  Even something as simple as
#' using \code{knitr::spin} on a script that reads a file in a different
#' directory cannot be easily done in a way that allows both running the script
#' directly and using \code{spin} on it.
#'
#' \code{spinMyR} improves basic \code{spin} in a few ways. You get to decide:
#' - What the working directory ofthe R script is
#' - Where the output files will go
#' - Where the figures used in the markdown will go
#' @param file The path to the R script (if \code{wd} is provided, then this
#' path is relative to \code{wd}).
#' @param wd The working directory to be used in the R script. See 'Detailed:
#' Arguments'.
#' @param outDir The output directory (if \code{wd} is provided, then this path
#' is relative to \code{wd}). Defaults to the directory containing the R script.
#' @param figDir The name (or path) of the directory containing the figures
#' generated for the markdown document. See 'Detailed Arguments'.
#' @param chunkOpts List of chunk options to use. See \code{?knitr::opts_chunk}
#' for a list of chunk options.
#' @param verbose If TRUE, then show the progress of knitting the document.
#' @section Possible future improvements:
#' - Add support to only produce one of [Rmd, md, HTML]
#' @section Detailed Arguments:
#' The \code{wd} argument is very important and is set to the current working
#' directory of the caller by default. The path of the input file and the path
#' of the output directory are both relative to \code{wd}. Moreover, any code
#' in the R script that reads or writes files will use \code{wd} as the
#' working directory.
#'
#' The \code{figDir} argument is relative to the output directory, since the
#' figures accompanying a markdown file should ideally be placed in the same
#' directory. It is recommended to either leave \code{figDir} as default or
#' set it to a different name but not to a different directory. Because of the
#' way \code{knitr} works, there are a few known minor issues if \code{figDir}
#' is set to a different directory.
#' @export
#' @examples
#' if (requireNamespace("knitr", quietly = TRUE)) {
#'   if (requireNamespace("markdown", quietly = TRUE)) {
#'      \dontrun{spinMyR("R/script.R")}
#'      \dontrun{spinMyR("script.R", wd = "R")}
#'      \dontrun{spinMyR("script.R", wd = "R", outDir = "reports")}
#'      \dontrun{spinMyR("script.R", wd = "R", outDir = "reports",
#'               figDir = "figs")}
#'   }
#' }
#' @seealso \code{\link[knitr]{spin}}
spinMyR <- function(file, wd, outDir, figDir,
										chunkOpts = list(tidy = FALSE), verbose = FALSE) {
	rsaladRequire("knitr")
	rsaladRequire("markdown")
	rsaladRequire("R.utils")

	if (missing(file)) {
		stop("`file` argument was not supplied.")
	}

	# Default working directory is where the user is right now
	if (missing(wd)) {
		wd <- getwd()
	}

	wd <- normalizePath(wd)

	# Determine the path fo the input file, either absolute path or relative to wd
	if (!R.utils::isAbsolutePath(file)) {
		file <- file.path(wd, file)
	}
	suppressWarnings({
		file <- normalizePath(file)
	})

	if (!R.utils::isFile(file)) {
		stop("Could not find input file: ", file)
	}

	inputDir <- dirname(file)

	# Default output directory is where input is located, otherwise build the path
	# relative to the working directory
	if (missing(outDir)) {
		outDir <- inputDir
	} else if(!R.utils::isAbsolutePath(outDir)) {
		outDir <- file.path(wd, outDir)
	}
	dir.create(outDir, recursive = TRUE, showWarnings = FALSE)
	outDir <- normalizePath(outDir)

	if (missing(figDir)) {
		figDir <- "markdown-figs"
	}

	# Save a copy of the original knitr and chunk options
	oldOptsKnit <- knitr::opts_knit$get()
	oldOptsChunk <- knitr::opts_chunk$get()

	# Get the filenames for all intermediate files
	fileName <- sub("(\\.[rR])$", "", basename(file))
	fileRmdOriginal <- file.path(inputDir, paste0(fileName, ".Rmd"))
	fileRmd <- file.path(outDir, paste0(fileName, ".Rmd"))
	fileMd <- file.path(outDir, paste0(fileName, ".md"))
	fileHtml <- file.path(outDir, paste0(fileName, ".html"))

	# On Windows (as opposed to unix systems), file.path does not append a
	# separator at the end, so add one manually to ensure this works
	# cross-platform
	figDir <- file.path(figDir, .Platform$file.sep)

	# Set up the directories correctly (this took many many hours to figure out..)
	knitr::opts_knit$set(root.dir = wd)
	knitr::opts_knit$set(base.dir = outDir)
	knitr::opts_chunk$set(fig.path = figDir)

	# Use the user-defined chunk options
	knitr::opts_chunk$set(chunkOpts)

	# Create the figure directory if it doesn't exist (otherwise we get errors)
	fullFigPath <- file.path(knitr::opts_knit$get("base.dir"),
													 knitr::opts_chunk$get("fig.path"))
	dir.create(fullFigPath, recursive = TRUE, showWarnings = FALSE)

	# -------

	# Define a function to clean up all the directories and settings we changed
	# This function will be called regardless of whether spinning works
	# so that side-effects will not persist if an error occurs
	cleanup <- function() {
		# Because of a bug in knitr, the figures directory is created in the
		# working directory as well as where it should be, but with nothing in it
		# We can't use normalizePath because we don't want to get the trailing
		# file separator since that will prevent unlink from working properly
		figDirName <- file.path(dirname(figDir), basename(figDir))
		suppressWarnings(unlink(figDirName, recursive = TRUE))
		if (length(list.files(fullFigPath)) == 0) {
			suppressWarnings(unlink(fullFigPath, recursive = TRUE))
		}

		# Restore original knitr and chunk options, to minimize unwanted side-effects
		knitr::opts_knit$set(oldOptsKnit)
		knitr::opts_chunk$set(oldOptsChunk)
	}

	# This is the guts of this function - take the R script and produce HTML
	# in a few simple steps
	tryCatch({
		knitr::spin(file, format = "Rmd", knit = FALSE)
		file.rename(fileRmdOriginal,
								fileRmd)
		knitr::knit(fileRmd,
								fileMd,
								quiet = !verbose)
		markdown::markdownToHTML(fileMd,
														 fileHtml)
		}, finally = {
			cleanup()
		}
	)

	message(paste0("spinMyR output in: ", outDir))
}
