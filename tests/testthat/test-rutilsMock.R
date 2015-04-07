context("rutilsMock")

# turn off the tests for now becuase I can't figure out a nice way to ensure
# the directory paths will be correct both when doing a check and when testing
# using devtools::test()

if (FALSE) {

test_that("isDirectoryMock is TRUE when passed a directory", {
  expect_true(isDirectoryMock("../../R"))
  expect_true(isDirectoryMock("../../R/"))
  expect_true(isDirectoryMock("../../tests"))
})

test_that("isDirectoryMock is FALSE when passed a file or non-existent dir", {
  expect_false(isDirectoryMock("../../DESCRIPTION"))
  expect_false(isDirectoryMock("../../NAMESPACE"))
  expect_false(isDirectoryMock("../../lalanodir"))
})

test_that("isFileMock is TRUE when passed a file", {
  expect_true(isFileMock("../../DESCRIPTION"))
  expect_true(isFileMock("../../NAMESPACE"))
})

test_that("isFileMock is FALSE when passed a directory or non-existent file", {
  expect_false(isFileMock("../../R"))
  expect_false(isFileMock("../../R/"))
  expect_false(isFileMock("../../lalanofile"))
})

test_that("isAbsolutePathMock is TRUE when passed an absolute path (including Windows/unix style or ~)", {
  expect_true(isAbsolutePathMock("~"))
  expect_true(isAbsolutePathMock("/"))
  expect_true(isAbsolutePathMock("/home"))
  expect_true(isAbsolutePathMock("C:"))
  expect_true(isAbsolutePathMock("D:"))
})

test_that("isAbsolutePathMock is FALSE when passed a relative path", {
  expect_false(isAbsolutePathMock(""))
  expect_false(isAbsolutePathMock("."))
  expect_false(isAbsolutePathMock(".."))
  expect_false(isAbsolutePathMock("x"))
  expect_false(isAbsolutePathMock("x/y"))
  expect_false(isAbsolutePathMock("\\"))
  expect_false(isAbsolutePathMock("CD:"))
})

}
