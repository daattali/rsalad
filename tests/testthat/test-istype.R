context("istype")

test_that("is.bool is TRUE when passed a single boolean value (only TRUE/FALSE)", {
  expect_true(is.bool(TRUE))
  expect_true(is.bool(FALSE))
  expect_true(is.bool(c(TRUE)))
})

test_that("is.bool is FALSE when passed a single non-boolean value, including NA", {
  expect_false(is.bool(0))
  expect_false(is.bool(5))
  expect_false(is.bool("x"))
  expect_false(is.bool(NA))
  expect_false(is.bool(NULL))
})

test_that("is.bool is FALSE when passed multiple boolean values", {
  expect_false(is.bool(c(TRUE, TRUE)))
  expect_false(is.bool(c(TRUE, FALSE)))
})

test_that("is.string is TRUE when passed a single string", {
  expect_true(is.string(""))
  expect_true(is.string("abc"))
  expect_true(is.string(c("x")))
  expect_true(is.string(paste("a", "b")))
  expect_true(is.string(letters[1]))
})

test_that("is.string is FALSE when passed a single non-string", {
  expect_false(is.string(NA))
  expect_false(is.string(NULL))
  expect_false(is.string(0))
  expect_false(is.string(5))
  expect_false(is.string(TRUE))
})

test_that("is.string is FALSE when passed multiple string values", {
  expect_false(is.string(c("a", "b")))
  expect_false(is.string(letters[1:5]))
})

