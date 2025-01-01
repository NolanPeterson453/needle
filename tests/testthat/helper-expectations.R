expect_guid <- function(object) {
  act <- testthat::quasi_label(rlang::enquo(object), arg = "object")
  act$is_guid <- is_guid(act$val)
  testthat::expect(
    act$is_guid == TRUE,
    sprintf("%s is not a valid GUID", act$label)
  )
  invisible(act$val)
}