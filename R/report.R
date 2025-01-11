report <- S7::new_class("report",
  parent = workspace_contained_item,
  properties = list(
    item_type = S7::new_property(
      S7::class_character,
      setter = function(self) {
        if (!is.null(self@item_type)) {
          rlang::abort("@item_type is read-only", call. = FALSE)
        }
        self@item_type <- "report"
        self
      }
    ),
    definition = S7::new_property(
      S7::class_list,
      setter <- function(self, value) {
        self@definition <- definition_from_path(value, self@item_type)
        self
      }
    )
  )
)


# Generic Methods
S7::method(create_fabric_item, report) <- function(
  x,
  description = ""
) {
  if (!(is.character(description))) {
    rlang::abort("new_description must be of class character")
  }
  url <- stringr::str_glue(
    "{base_url}/reports",
    base_url = x@base_url
  )
  method <- "POST"
  body <- list(
    definition = x@definition,
    displayName = x@item_name,
    description = description
  )
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method) |>
    httr2::req_body_json(body)

  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 201) {
    message("request complete")
    resp <- httr2::resp_body_json()
  } else if (status_code == 202) {
    message("request accepted and in progress")
    resp <- httr2::resp_body_html()
  }
  return(resp)
}


S7::method(delete_fabric_item, report) <- function(x) {
  url <- stringr::str_glue(
    "{base_url}/reports/{report_id}",
    base_url = x@base_url,
    report_id = x@item_id
  )
  method <- "DELETE"
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method)
  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 201) {
    delete_message <- stringr::str_glue(
      "request complete successfully deleted {type} {name} in {workspace}",
      type = x@item_type,
      name = x@item_name,
      workspace = x@workspace_name
    )
    message(delete_message)
  }
  return(NULL)
}


S7::method(get_fabric_item, report) <- function(x) {
  url <- stringr::str_glue(
    "{base_url}/reports/{report_id}",
    base_url = x@base_url,
    report_id = x@item_id
  )
  method <- "GET"
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method)
  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 200) {
    resp <- httr2::resp_body_json() |>
      tibble::tibble()
  }
  return(resp)
}

S7::method(get_fabric_item_def, report) <- function(x) {
  url <- stringr::str_glue(
    "{base_url}/reports/{report_id}/getDefinition",
    base_url = x@base_url,
    report_id = x@item_id
  )
  method <- "POST"
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method)
  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 201) {
    message("request complete")
    resp <- httr2::resp_body_json()
  } else if (status_code == 202) {
    message("request accepted and in progress")
    resp <- httr2::resp_body_html()
  }
  return(resp)
}

S7::method(update_fabric_item, report) <- function(
  x,
  new_report_name = NULL,
  new_description = ""
) {
  # Validate that new_report_name is correct type
  # if is null set to existing value
  if (!(is.null(new_report_name)) && !(is.character(new_report_name))) {
    rlang::abort("new_report_name must be of class character")
  } else
    if (is.null(new_report_name)) {
      new_report_name <- x@item_name
    }
  if (!(is.character(new_description))) {
    rlang::abort("new_description must be of class character")
  }
  url <- stringr::str_glue(
    "{base_url}/reports/{report_id}",
    base_url = x@base_url,
    report_id = x@item_id
  )
  body <- list(
    displayName = new_report_name, # no lint
    description = new_description
  )
  method <- "PATCH"
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method) |>
    httr2::req_body_json(body)
  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 200) {
    message("request complete")
  }
  return(NULL)
}


S7::method(update_fabric_item_def, report) <- function(
  x,
  definition_path
) {
  x@definition <- definition_path
  url <- stringr::str_glue(
    "{base_url}/reports/updateDefinition",
    base_url = x@base_url
  )
  method <- "POST"
  body <- list(
    definition = x@definition
  )
  req <- httr2::request(url) |>
    httr2::oauth_client_req_auth(x@fabric_client) |>
    httr2::req_method(method) |>
    httr2::req_body_json(body)

  resp <- httr2::req_perform(req)
  status_code <- resp |> httr2::resp_status()
  if (status_code == 201) {
    message("request complete")
    resp <- httr2::resp_body_json()
  } else if (status_code == 202) {
    message("request accepted and in progress")
    resp <- httr2::resp_body_html()
  }
  return(resp)
}