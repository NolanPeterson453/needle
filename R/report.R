report <- S7::new_class("report",
  parent = workspace_contained
)

S7::method(get_id, semantic_model) <- function(x, auth_token) {
  endpoint <- stringr::str_glue(
    "workspaces/{workspace_id}/reports",
    workspace_id = x@workspace_id
  )
  resp <- invoke_fabric_api(
    endpoint,
    auth_token,
    "Fabric",
    "GET",
  ) |> httr2::resp_body_json()

  id <- resp
  return(id)
}