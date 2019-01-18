context("Metadata queries study URL retrieval works")
test_that("Core functions work when you have a key", {

  testthat::skip_on_cran()

  x <- get_study_details("sonar.national_exposure")
  testthat::expect_is(x, "data.frame")

  x <- get_file_details("sonar.fdns_v2", "2018-06-15-1529049662-fdns_aaaa.json.gz")
  testthat::expect_is(x, "data.frame")

  x <- list_studies()
  testthat::expect_is(x, "data.frame")

})
