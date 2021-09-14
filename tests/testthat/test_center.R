context("Center length")

test_that("center returns correct length", {
  a <- c(1, 2, 3, 4, 5, 6)
  b <- c(1, NA, 3, NA, 5, 6)
  expect_equal(length(center(a)), length(a))
  expect_equal(length(center(b)), length(b))
  expect_equal(length(center(b, na.rm = FALSE)), length(b))
})
