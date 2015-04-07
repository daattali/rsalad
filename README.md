# rsalad

[![Build Status](https://travis-ci.org/daattali/rsalad.svg?branch=master)](https://travis-ci.org/daattali/rsalad)

rsalad, like any other salad, is a mixture of different healthy vegetables that
you should be having frequently and that can make your life much better. Except
that instead of vegetables, rsalad provides you with R functions.

This package was born as a result of me constantly breaking the DRY principle
by copy-and-pasting functions from old projects into new ones. Hence, the
functions in rsalad do not have a single common topic, but they are all either
related to manipulating data.frames, improving ggplot2 plots, or general
productivity utilities.

This package does not solve any one large problem, but rather has several
functions that can prove to be useful and time-saving if you happen to need
to perform one of the tasks implemented by rsalad.

## Note

All the ggplot2 related functions have graduated out of this package and are now
available in the `ggExtra` package. `ggExtra` can be downloaded from
[CRAN](http://cran.r-project.org/web/packages/ggExtra/index.html) or
[GitHub](https://github.com/daattali/ggExtra).

## Installation

rsalad is currently only available through GitHub and can be downloaded
easily using devtools.

```
# install.packages("devtools")
devtools::install_github("daattali/rsalad")
```

## Getting started

There are many different usecases for rsalad.  See the
[overview vignette](https://github.com/daattali/rsalad/blob/master/vignettes/overview.md)
for a more detailed walk-through of the package or the
[spinMyR vignette](https://github.com/daattali/rsalad/blob/master/vignettes/spinMyR.md) for
details about the `spinMyR()` function.

```
browseVignettes("rsalad")
vignette("overview", "rsalad")
vignette("spinMyR", "rsalad")
vignette("dfCountPerf", "rsalad")
```

Alternatively, see the help file for any specific function for a complete
detailed explanation of the function. For example `?rsalad::moveFront`.

Below is a very brief introduction to the functions in rsalad. The package
must first be loaded for the examples to work `library("rsalad")`.

### `spinMyR()`: create markdown/HTML reports from R scripts with no hassle
`spinMyR()` is an improvement on `knitr::spin`. `spinMyR` makes it
easy to use spin on R scripts that require a certain working directory that is
not the script's directory, while allowing the script to still function
on its own.  `spinMyR` also lets you select where to output the results, and
adds several more features.

```
spinMyR("script.R", wd = "R", outDir = "reports", figDir = "figs")
```

### `dfFactorize()`: convert data.frame columns to factors
Convert character columns in a data.frame to factors.

```
df <- data.frame(a = 1:3, b = letters[1:3], c = LETTERS[1:3],
								 stringsAsFactors = FALSE)
str(dfFactorize(df))
```

### `move` functions: move columns to front/back
Move specific columns in data.frames to be the first or last columns.

```
df <- data.frame(a = 1:3, b = 4:6, c = 7:9, d = 10:12)
moveFront(df, d, c)
moveBack_(df, c("d", "c"))
```

### `dfCount()`: count number of rows per group
Count how many times each distinct value of a data.frame column is observed.

```
df <- data.frame(col = c(rep("a", 2), rep("b", 3)))
dfCount(df, "col")
```

### `%nin%` and `notIn()`
Determine if values in the first argument don't exist in the second argument.
Opposite of the `%in%` operator.

```
c("a", "A") %nin% letters
```

### `tolowerfirst()`: convert first character to lower case
Given a character vector, convert the first character to lower case.

```
tolowerfirst(c("CamelCase", "ALLCAPS"))
```

### `setdiffsym()`: symmetric set difference
Perform symmetric set difference, as opposed to `base::setdiff()` which
performs assymetric set difference.

```
setdiffsym(1:4, 3:5)
```
