#' Creates a new OAuth client for Fabric service.
#'
#' `fabric_client()` Creates a new OAuth client for Fabric service.
#' It does this by acting as a wrapper around `httr2::oauth_client()`
#'
#' @param client_id, input string. The id of the service principle
#' used to access Fabric API.
#' @param fabric_secret input string. The password for the service principle.
#' @param tenant_id Input string. The id of the Microsoft Fabric Tenant.
#' @returns An httr2 OAuth Client for Fabric service.
#' @export
fabric_client <- function(
  client_id,
  client_secret,
  tenant_id
) {
  client <- httr2::oauth_client(
    id = client_id,
    secret = httr2::obfuscate(client_secret),
    token_url = stringr::str_glue(
      "https://login.microsoftonline.com/{tenant_id]/oauth2/v2.0/token",
      tenant_id
    ),
    name = "needle",
    auth = "header"
  )
  return(client)
}