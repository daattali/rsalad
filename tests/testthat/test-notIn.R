context("notIn")

test_that("%nin% basic functionality works", {
	expect_equal("a" %nin% letters, FALSE)
	expect_equal("a" %nin% LETTERS, TRUE)
	expect_equal(c("a", "A") %nin% letters, c(FALSE, TRUE))
})

test_that("notIn and %nin% are the same", {
	lhs <- c("a", "B", "cd")
	expect_equal(lhs %nin% letters, notIn(lhs, letters))
})

test_that("%nin% works with NULL", {
	expect_equal(NULL %nin% letters, logical(0))
})
