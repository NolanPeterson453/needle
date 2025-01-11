#' Retrieves the details of a fabric item.
#'
#' `get_fabric_item()` is used to retrive the details of a fabric items 
#' and return as a tibble.
#'
#' @param x The instance of the fabric item to create.
#' @returns tibble
#'
get_fabric_item <- S7::new_generic("get_fabric_item", x)