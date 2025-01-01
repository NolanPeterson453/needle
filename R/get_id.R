#' Get the id of a Fabric Object.
#'
#' `get_id()` is used to retreive the GUID id of a Fabric Object.
#'
#' @param x Fabric object to get the id of.
#' Can be Workspace, Semantic Model, Report, Paginated Report, etc...
#' @param auth_token Input string. The bearer authentication token.
#' @returns A valid GUID.
#'
get_id <- S7::new_generic("get_id", x, function(x, auth_token) {
  S7::S7_dispatch()
})