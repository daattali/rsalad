# rsalad 0.1.0

2015-12-07

- **BREAKING CHANGE** `spinMyR()` has moved to the `ezknitr` package
([https://github.com/daattali/ezknitr](https://github.com/daattali/ezknitr)).


# rsalad 0.0.2.2

2015-10-23

- `spinMyR()` gains new arguments `keepRmd` (default: `FALSE`) and `keepMd` (default: `TRUE`) (#15)

# rsalad 0.0.2.1

2015-04-06

- **BREAKING CHANGE** All ggplot2 related functions have now moved to the `ggExtra` package
([https://github.com/daattali/ggExtra](https://github.com/daattali/ggExtra)).

# rsalad 0.0.2.0

2015-01-15

- Added `setupSpinMyRtest()` which will set up a test directory to allow users
to experiment with `spinMyR()`  
- Complete revamp of the [`spinMyR` vignette](https://github.com/daattali/rsalad/blob/master/inst/doc/spinMyR.md)

# rsalad 0.0.1.3

2015-01-11

Refactor some code to improve efficiency and update spinMyR documentation. 


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
