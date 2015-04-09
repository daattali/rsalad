context("rutilsMock")

test_that("isDirectoryMock is TRUE when passed a directory", {
  expect_true(isDirectoryMock("."))
  expect_true(isDirectoryMock("../testthat"))
  expect_true(isDirectoryMock("../../tests"))
  expect_true(isDirectoryMock("../../tests/"))
})

test_that("isDirectoryMock is FALSE when passed a file or non-existent dir", {
  expect_false(isDirectoryMock("nosuchdir"))
  expect_false(isDirectoryMock("nosuchdir/"))
  expect_false(isDirectoryMock("test-rutilsMock.R"))
  expect_false(isDirectoryMock("./test-rutilsMock.R"))
  expect_false(isDirectoryMock("../testthat.R"))
})

test_that("isFileMock is TRUE when passed a file", {
  expect_true(isFileMock("test-rutilsMock.R"))
  expect_true(isFileMock("./test-rutilsMock.R"))
  expect_true(isFileMock("../testthat.R"))
})

test_that("isFileMock is FALSE when passed a directory or non-existent file", {
  expect_false(isFileMock("."))
  expect_false(isFileMock("../testthat"))
  expect_false(isFileMock("../../tests"))
  expect_false(isFileMock("../../tests/"))
  expect_false(isFileMock("test-nosuchfile.R"))
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
