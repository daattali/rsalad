context("move")

df <- data.frame(a = 1:3, b = 4:6, c = 7:9, d = 10:12)

test_that("moveFront/moveBack NSE versions work", {
	expect_equal(colnames(moveFront(df, d)),
							 c("d", "a", "b", "c"))
	expect_equal(colnames(moveFront(df, d, c)),
							 c("d", "c", "a", "b"))
	expect_equal(colnames(moveFront(df, c, d)),
							 c("c", "d", "a", "b"))
	expect_equal(colnames(moveBack(df, b, a)),
							 c("c", "d", "b", "a"))
})

test_that("moveFront/moveBack_ SE versions work", {
	expect_equal(colnames(moveFront_(df, c("b", "d"))),
							 c("b", "d", "a", "c"))
	expect_equal(colnames(moveBack_(df, "a")),
							 c("b", "c", "d", "a"))
})

test_that("move functions throw an error when a column name doesn't exist", {
	expect_error(moveFront(df, z))
	expect_error(moveBack(df, z))
	expect_error(moveFront_(df, "z"))
	expect_error(moveBack_(df, "z"))
})

test_that("move retains the original data.frame/tbl_df class", {
	expect_false(dplyr::is.tbl(moveFront(df, c)))
	expect_true(dplyr::is.tbl(moveFront(dplyr::tbl_df(df), c)))
})
