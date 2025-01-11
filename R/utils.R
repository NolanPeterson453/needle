#' Test if string is a valid GUID.
#'
#' `is_guid()` returns a logical vector with 'TRUE' for each
#' element of 'string' that is a valid GUID.
#'
#' @param input_string Input string. The string to test if is a valid GUID.
#' @returns Logical
#'
is_guid <- function(input_string) {
  guid_regex <- paste(
    "/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]",
    "{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i"
  )
  return(stringr::str_detect(input_string, guid_regex))
}

