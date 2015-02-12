context("between")

test_that("between basic functionality works", {
  expect_true(5 %btwn% c(1, 10))
  expect_true(5 %btwn% c(5, 10))
  expect_false(5 %btwn% c(6, 10))
})

test_that("between works when the range is not in order", {
  expect_true(6 %btwn% c(10, 5))
  expect_false(4 %btwn% c(10, 5))
})

test_that("between works on vectors", {
  expect_equal(1:5 %btwn% c(4, 10),
               c(FALSE, FALSE, FALSE, TRUE, TRUE))
})

test_that("between `inclusive` parameter is respected", {
  expect_equal(1:5 %btwn% c(1, 5),
               c(TRUE, TRUE, TRUE, TRUE, TRUE))
  expect_equal(between(1:5, c(1, 5)),
               c(TRUE, TRUE, TRUE, TRUE, TRUE))
  expect_equal(between(1:5, c(1, 5), inclusive = FALSE),
               c(FALSE, TRUE, TRUE, TRUE, FALSE))
})
