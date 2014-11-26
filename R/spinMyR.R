library(knitr)
library(markdown)

# Known problems:
# 1. if the fidDir is more than one directory deep and no figures
# are produced, a figures directory will be created and only the deepest
# directory will be deleted.
# 2. if the fidDir is more than one directory deep, the working directory
# will have directories created with the same names
# 3. if the fidDir is
spinMyR <- function(file,
										wd,
										outDir,
										figDir = "markdown-figs",
										chunkOpts = list(tidy = FALSE)) {
	# file is relative to wd
	# wd is where the script assumes you are when the file reads/writes files
	#outdir is relative to wd (by default, same direcotry as input R script)
	#fidDir is relative to outDir

	if (missing(wd)) {
		wd <- getwd()
	}

	file <- file.path(wd, file)

	if (missing(outDir)) {
		outDir <- dirname(file)
	} else {
		outDir <- file.path(wd, outDir)
	}

	if (!file.exists(file)) {
		stop("no input")
	}
	print(file.path(outDir))
	# Save a copy of the original knitr and chunk options
	oldOptsKnit <- opts_knit$get()
	oldOptsChunk <- opts_chunk$get()

	fileName <- sub("(\\.[rR])$", "", basename(file))
	inputDir <- dirname(file)

	dir.create(outDir, recursive = TRUE, showWarnings = FALSE)

	fileRmd <- file.path(outDir, paste0(fileName, ".Rmd"))
	fileMd <- file.path(outDir, paste0(fileName, ".md"))
	fileHtml <- file.path(outDir, paste0(fileName, ".html"))
	fidDir <- file.path(fidDir, .Platform$file.sep)

	opts_knit$set(root.dir = wd)
	opts_knit$set(base.dir = outDir)
	opts_chunk$set(fig.path = fidDir)

	opts_chunk$set(chunkOpts)

	fullFigPath <- file.path(opts_knit$get("base.dir"), opts_chunk$get("fig.path"))
	dir.create(fullFigPath, recursive = TRUE, showWarnings = FALSE)

	spin(file, format = "Rmd", knit = FALSE)
	file.rename(file.path(inputDir, paste0(fileName, ".Rmd")),
							fileRmd)
	knit(fileRmd,
			 fileMd)
	markdownToHTML(fileMd,
								 fileHtml)

	# because of a bug in knitr/markdown, the figs directory is created in the
	# working directory as well but with nothing in it
	fidDirName <- file.path(dirname(fidDir), basename(fidDir))
	suppressWarnings(unlink(fidDirName, recursive = TRUE))
	if (length(list.files(fullFigPath)) == 0) {
		suppressWarnings(unlink(fullFigPath, recursive = TRUE))
	}

	# Restore original knitr and chunk options, to minimize unwanted side-effects
	opts_knit$set(oldOptsKnit)
	opts_chunk$set(oldOptsChunk)
}
