semantic_model <- S7::new_class("semantic_model",
  parent = workspace_contained,
  properties = list(
    name = S7::new_property(
      S7::class_character
    ),
    id = S7::new_property(
      S7::class_character,
      getter = function(self) {
        endpoint <- stringr::str_glue(
          "workspaces/{workspace_id}/semanticModels",
          workspace_id = self@workspace_id
        )
        resp <- invoke_fabric_api(
          endpoint,
          self@fabric_client,
          "Fabric",
          "GET",
        ) |> httr2::resp_body_json()
        id <- resp$value |>
          as.data.frame() |>
          dplyr::fitler(name == self@name) |>
          dplyr::select(id)
        return(id)
      }
    )
  )
)


S7::method(refresh, semantic_model) <- function(
    self,
    refresh_type = "automatic",
    commit_mode = "transactional",
    apply_refresh_policy = FALSE) {
  refresh_types <- c(
    "automatic",
    "calculate",
    "clearValues",
    "dataOnly",
    "defragment",
    "full"
  )
  commit_modes <- c(
    "partialBatch",
    "transactional"
  )
  if (!(refresh_type %in% refresh_types)) {
    rlang::abort(
      sprintf("refresh_type must be of type %v", refresh_types)
    )
  }
  if (!(commit_mode %in% commit_modes)) {
    rlang::abort(
      sprintf("commit_mode must be on of the following: %v", commit_modes)
    )
  }
  if (!(rlang::is_logical(apply_refresh_policy))) {
    rlang::abort(
      print("apply_refresh_policy must be a logical")
    )
  }
  req_body <- list(
    type <- refresh_type, # nolint
    commitMode <- commit_mode, # nolint
    applyRefreshPolicy <- apply_refresh_policy # nolint
  )
  endpoint <- stringr::str_glue(
    "groups/{workspace_id}/datasets/{semantic_model_id}/refreshes",
    workspace_id = self@workspace_id,
    semantic_model_id = self@id
  )
  refresh_resp <- invoke_fabric_api(
    endpoint,
    self@fabric_client,
    "PowerBI",
    "POST",
    req_body
  )
  # TODO ping request until complete and return refresh status.
  return(refresh_resp)
}
