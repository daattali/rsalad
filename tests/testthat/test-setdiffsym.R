context("setdiffsym")

test_that("setdiffsym is symmetric", {
	expect_equal(sort(setdiffsym(1:3, 2:4)),
							 sort(setdiffsym(2:4, 1:3)))
})

test_that("setdiffsym returns nothing is both vectors are equal", {
	expect_equal(length(setdiffsym(1:5, 1:5)), 0)
})

test_that("setdiffsym returns unique elements regardless of which argument
					it was in", {
	expect_equal(setdiffsym(1:6, 1:5), c(6))
	expect_equal(setdiffsym(1:5, 1:6), c(6))
})
