# rsalad 0.0.1.2

2014-11-26

## New functions

Added `spinMyR()`, which is an improvement on `knitr::spin`. `spinMyR` makes it
easy to use spin on R scripts that require a certain working directory that is
not the script's directory, while allowing the script to still function
on its own.  `spinMyR` also lets you select where to output the results. See
more improvements and details `?rsalad::spinMyR`.


# rsalad 0.0.1.1

## New functions

* `setdiffsym`: symmetric set difference

## Bug fixes

* Small fix in `move` code

## Minor improvements

* Modify code in `dfCount` to make use of `lazyeval` package
