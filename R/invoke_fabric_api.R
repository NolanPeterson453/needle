#' Invoke Fabric or Power BI api.
#'
#' `invoke_fabric_api()` makes a call to the Microsoft Fabric or Power BI api.
#'
#' @param endpoint Input string. The endpoint to call.
#' @param fabric_client A Fabric Oauth client object
#' of class httr2_oauth_client.
#' @param api_version Input string. The version of the api to use.
#' Either "PowerBI" or "Fabric".
#' @param method Input string. The rest method of the call.
#' Must be "GET", "POST", "PUT", "PATCH" or "DELETE"
#' @param body Input list. A list to be converted to json body of request.
#' @param verbose Input boolean. If true shows request to be
#' sent to API and response.
#' @returns An httr2 response object.
#' @export
invoke_fabric_api <- function(
  endpoint,
  fabric_client,
  api_version,
  method,
  body = NULL,
  verbose = FALSE
) {
  if (api_version == "Fabric") {
    base_url <- "https://api.fabric.microsoft.com/v1/"
  } else
    if (api_version == "PowerBI") {
      base_url <- "https://api.powerbi.com/v1.0/myorg/"
    } else {
      rlang::abort("must provide valid api version, Fabric or PowerBI")
    }

  url <- paste(base_url, endpoint) |> utils::URLencode()

  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(fabric_client) |>
    httr2::req_method(method)
  if (exists(body)) {
    req <- req |> httr2::req_body_json(body)
  }

  withCallingHandlers(
    message = function(cnd) {
      if (verbose == TRUE) {
        message(cnd)
      }
    },
    message(httr2::req_dry_run(req))
  )
  resp <- httr2::req_perform(req)
  withCallingHandlers(
    message = function(cnd) {
      if (verbose == TRUE) {
        message(cnd)
      }
    },
    message(httr2::resp_raw(resp))
  )
  return(resp)
}
