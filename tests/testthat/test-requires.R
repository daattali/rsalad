context("requires")

test_that("rsaladRequire passes both a single value and a vector", {
  expect_that(rsaladRequire("base"), not(throws_error()))
  expect_that(rsaladRequire(c("base")), not(throws_error()))
  expect_that(rsaladRequire(c("base", "methods")), not(throws_error()))
})

test_that("rsaladRequire throws error for non-existent packages", {
  errorMsg <- function(pkg) paste0(pkg, ".*required for this function")

  expect_error(rsaladRequire("rsaladXYZ123"), errorMsg("rsaladXYZ123"))
  expect_error(rsaladRequire(c("rsaladXYZ123")), errorMsg("rsaladXYZ123"))
  expect_error(rsaladRequire(c("base", "methods", "rsaladXYZ123")), errorMsg("rsaladXYZ123"))
  expect_error(rsaladRequire(c("base", "rsaladXYZ123", "methods")), errorMsg("rsaladXYZ123"))
  expect_error(rsaladRequire(c("rsaladXYZ123", "base", "methods")), errorMsg("rsaladXYZ123"))
  expect_error(rsaladRequire(c("rsalad123XYZ", "rsaladXYZ123", "base")), errorMsg("rsalad123XYZ"))
})

test_that("rsaladSuggest passes both a single value and a vector", {
  expect_that(rsaladSuggest("base"), not(gives_warning()))
  expect_that(rsaladSuggest(c("base")), not(gives_warning()))
  expect_that(rsaladSuggest(c("base", "methods")), not(gives_warning()))
})

test_that("rsaladSuggest gives warning for non-existent packages", {
  warnMsg <- function(pkg) paste0(pkg, ".*recommended for this function")

  expect_warning(rsaladSuggest("rsaladXYZ123"), warnMsg("rsaladXYZ123"))
  expect_warning(rsaladSuggest(c("rsaladXYZ123")), warnMsg("rsaladXYZ123"))
  expect_warning(rsaladSuggest(c("base", "methods", "rsaladXYZ123")), warnMsg("rsaladXYZ123"))
  expect_warning(rsaladSuggest(c("base", "rsaladXYZ123", "methods")), warnMsg("rsaladXYZ123"))
  expect_warning(rsaladSuggest(c("rsaladXYZ123", "base", "methods")), warnMsg("rsaladXYZ123"))
  expect_warning(rsaladSuggest(c("rsalad123XYZ", "rsaladXYZ123", "base")), warnMsg("rsalad123XYZ"))
})

