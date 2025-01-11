#' Retrieves the definition of a fabric item.
#'
#' `get_fabric_item_def()` is used to retrieve the definition of a fabric item.
#' and return as a tibble.
#'
#' @param x The instance of the fabric item to get definition of.
#' @returns list
#'
get_fabric_item_def <- S7::new_generic("get_fabric_item_def", x)