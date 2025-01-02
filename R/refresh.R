#' Refresh Fabric object
#'
#' `refresh()` is used to refresh the data of a Fabric Object.
#'
#' @param self Fabric object to refresh,.
#' Can be Semantic Model, Report.
#' @returns refresh message.
#'
refresh <- S7::new_generic("refresh", self)