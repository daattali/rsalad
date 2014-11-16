context("tolowerfirst")

test_that("tolowerfirst basic functionality works", {
	expect_equal(
		tolowerfirst("ALLCAPS"),
		"aLLCAPS"
	)
})

test_that("tolowerfirst works on vectors", {
	expect_equal(
		tolowerfirst(c("CamelCase", "ALLCAPS")),
		c("camelCase", "aLLCAPS")
	)
})

test_that("tolowerfirst only changes alphabetical characters", {
	strings <- c("_ONE", "1234")
	expect_equal(tolowerfirst(strings), strings)
})

test_that("tolowerfirst only accepts character vectors", {
	errMsg <- "is.character\\(.*\\)"
	expect_error(tolowerfirst(5), errMsg)
	expect_error(tolowerfirst(data.frame()), errMsg)
})
