#' Set up a test directory to experiment with \code{spinMyR}
#'
#' This function creates a few directories that try to mimic a real
#' data-analysis project structure, and adds a simple R script and a data file.
#' After setting up these files and directories, you can run both
#' \code{knitr::spin} and \code{rsalad::spinMyR} on the R script to see the
#' benefits of \code{spinMyR}.
#'
#' The console output from this function will give more specific insturctions on
#' how to interact with this test directory.
#' @param loc The path where you want to set up the test directories.
#' @return The path to the root of the test directory.
#' @export
#' @examples
#' \dontrun{
#' library(rsalad)
#' tmp <- setupSpinMyRtest("~")
#' origwd <- setwd(tmp)
#' knitr::spin("container/R/spinMyRtest.R")
#' setupSpinMyRtest("..")
#' spinMyR("R/spinMyRtest.R", wd = "container")
#' setupSpinMyRtest("..")
#' spinMyR("R/spinMyRtest.R", wd = "container",
#'         outDir = "output", figDir = "coolplots")
#' setwd(origwd)
#' unlink(tmp, recursive = TRUE, force = TRUE)
#' }
#' @seealso \code{\link[rsalad]{spinMyR}}
#' @seealso \code{\link[knitr]{spin}}
setupSpinMyRtest <- function(loc = getwd()) {
  s <- try(
    system.file("examples", "spinMyRtest.R", package = "rsalad", mustWork = TRUE),
    silent = TRUE)
  if (class(s) == "try-error") {
    stop("Could not find example file")
  }

  testdir <- file.path(loc, "spinMyRtest")
  unlink(list.files(testdir), recursive = TRUE, force = TRUE)

  container <- file.path(testdir, "container")
  rdir <- file.path(container, "R")
  datadir <- file.path(container, "data")
  dir.create(rdir, showWarnings = FALSE, recursive = TRUE)
  dir.create(datadir, showWarnings = FALSE)

  file.copy(from = s, to = rdir)
  cat("10 20 30", file = file.path(datadir, "numbers.txt"))

  message(paste0("spinMyR demo was set up at\n", normalizePath(testdir), "\n\n",
          "To experiment with spinMyR, set that as your working directory and ",
          "run following commands. After each command, look where all the ",
          "output was created and look at the resulting output to see ",
          "the differences.\n"))

  message('   1.   knitr::spin("container/R/spinMyRtest.R")')
  message('   2.   rsalad::spinMyR("R/spinMyRtest.R", wd = "container")')
  message('   3.   rsalad::spinMyR("R/spinMyRtest.R", wd = "container",')
  message('                        outDir = "output", figDir = "coolplots")')

  message(paste0('\nNote: to start with a clean state after each of the above ',
          'commands, run `rsalad::setupSpinMyRtest("..")` to set up the demo ',
          'directories again.'))

  invisible(testdir)
}
