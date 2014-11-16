context("dfCount")

df <- data.frame(col = c(rep("a", 2), rep("b", 3)))

test_that("dfCount basic functionality works", {
	result <- dfCount(df, "col")
	expect_equal(nrow(result), 2)
	expect_true(all(result$col == c("b", "a")))
	expect_true(all(result$total == c(3, 2)))
})

test_that("dfCount sort argument affects sorting", {
	result <- dfCount(df, "col", sort = FALSE)
	expect_equal(nrow(result), 2)
	expect_true(all(result$col == c("a", "b")))
	expect_true(all(result$total == c(2, 3)))
})

test_that("dfCount name argument changes resulting column name", {
	result <- dfCount(df, "col", name = "num")
	expect_match(colnames(result)[2], "num")
})

test_that("dfCount sort argument must be boolean", {
	expect_error(dfCount(df, "col", sort = 5), "is.bool")
	expect_error(dfCount(df, "col", sort = "a"), "is.bool")
})
