#' The class constructor of class workspace_contained_item
#'
#' `workspace_contained` is used to instatiate a new
#' workspace contained object. Used primarly as a parent class to objects
#' contained in Fabric workspaces.
#'
#' @param fabric_client A Fabric Oauth client object
#' of class httr2_oauth_client.
#' @param workspace_id GUID input. The id of the contianing workspace.
#' @param workspace_name string input. The name of the containing workspace.
#' @returns A an object of class workspace_contained.
#'
workspace_contained_item <- S7::new_class("workspace_contianed",
  properties = list(
    fabric_client <- S7::new_property(
      httr2::httr2_oauth_client
    ),
    item_id <- S7::new_property(
      S7::class_character
    ),
    item_name <- S7::new_property(
      S7::class_character
    ),
    workspace_id <- S7::new_property(
      S7::class_character
    ),
    workspace_name <- S7::new_property(
      S7::class_character
    ),
    base_url = S7::new_property(
      S7::class_character,
      setter = function(self) {
        if (!is.null(self@item_type)) {
          rlang::abort("@base_url is read-only", call. = FALSE)
        }
        self@base_url <- stringr::str_glue(
          "https://api.fabric.microsoft.com/v1/workspaces/{workspace_id}",
          workspace_id = self@workspace_id
        )
        self
      }
    )
  )
)