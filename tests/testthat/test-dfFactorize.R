context("dfFactorize")

df <- data.frame(a = 1:3, b = letters[1:3], c = LETTERS[1:3],
								 stringsAsFactors = FALSE)

test_that("dfFactorize basic functionality works", {
	expect_equal(as.logical(sapply(dfFactorize(df), is.factor)),
							 c(FALSE, TRUE, TRUE))
})

test_that("dfFactorize only argument works", {
	expect_equal(as.logical(sapply(dfFactorize(df, only = "b"), is.factor)),
							 c(FALSE, TRUE, FALSE))
})

test_that("dfFactorize ignore argument works", {
	expect_equal(as.logical(sapply(dfFactorize(df, ignore = "b"), is.factor)),
							 c(FALSE, FALSE, TRUE))
	expect_equal(dfFactorize(df, ignore = c("b", "c")),
							 df)
})

test_that("dfFactorize does not convert non-character columns", {
	expect_equal(dfFactorize(df, only = "a"),
							 df)
})

test_that("dfFactorize throws an error when a column name doesn't exist", {
	expect_error(dfFactorize(df, only = "z"))
	expect_error(dfFactorize(df, only = c("a", "z")))
	expect_error(dfFactorize(df, ignore = "z"))
	expect_error(dfFactorize(df, ignore = c("a", "z")))
})

test_that("dfFactorize throws an error when both only and ignore are set", {
	expect_error(dfFactorize(df, only = "b", ignore = "c"))
})
