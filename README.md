# rsalad

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

## Installation

rsalad is currently only available through GitHub and can be downloaded
easily using devtools.

```
# install.packages("devtools")
devtools::install_github("daattali/rsalad")
```

## Getting started

There are many different usecases for rsalad.  See the
[vignette](https://github.com/daattali/rsalad/blob/master/inst/doc/overview.md)
for a more detailed walk-through of the package.
```
vignette("overview", "rsalad")
```

Alternatively, see the help file for any specific function for a complete
detailed explanation of the function. For example `?rsalad::moveFront`.

Below is a very brief introduction to the functions in rsalad. The package
must first be loaded for the examples to work `library("rsalad")`.

### `%nin%` and `notIn()`
Determine if values in the first argument don't exist in the second argument.
Opposite of the `%in%` operator.

```
c("a", "A") %nin% letters
```

### `dfCount()`: count number of rows per group
Count how many times each distinct value of a data.frame column is observed.

```
df <- data.frame(col = c(rep("a", 2), rep("b", 3)))
dfCount(df, "col")
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

### `plotCount()`: plot count data
Create a bar plot of count data in a data.frame. Meant to be used with the
output from `dfCount()`.

```
df <- data.frame(col = c(rep("a", 2), rep("b", 3)))
countDat <- dfCount(df, "col")
plotCount(countDat)
```

### `ggplotLayers` functions: useful ggplot2 layers
`removeGrid()` and `rotateTextX()`: A small set of useful layers to add to
ggplot2 plots.

```
library("ggplot2")
df <- data.frame(x = paste("letter", LETTERS, sep = "_"),
                 y = seq(length(LETTERS)))
(p <- ggplot(df, aes(x, y)) + geom_point())
(p <- p + removeGrid())
(p <- p + rotateTextX())
```
