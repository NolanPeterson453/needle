#' Invoke refresh of Fabric object
#'
#' `invoke_refresh()` is used to refresh the data of a Fabric Object.
#'
#' @param self Fabric object to refresh,.
#' Can be Semantic Model, Report.
#' @returns refresh_id
#'
invoke_refresh <- S7::new_generic("invoke_refresh", self)