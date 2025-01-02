#' The class constructor of class workspace_contained
#'
#' `workspace_contained` is used to instatiate a new
#' workspace contained object. Used primarly as a parent class to objects
#' contained in Fabric workspaces.
#'
#' @param fabric_client A Fabric Oauth client object
#' of class httr2_oauth_client.
#' @param id GUID input. The id of the workspace contianed object.
#' @param name string input. The name of the workspace contained object
#' @param workspace_id GUID input. The id of the contianing workspace.
#' @param workspace_name string input. The name of the containing workspace.
#' @returns A an object of class workspace_contained.
#'
workspace_contained <- S7::new_class("workspace_contianed",
  properties = list(
    fabric_client <- S7::new_property(
      httr2::httr2_oauth_client
    ),
    id <- S7::new_property(
      S7::class_character
    ),
    name <- S7::new_property(
      S7::class_character
    ),
    workspace_id <- S7::new_property(
      S7::class_character
    ),
    workspace_name <- S7::new_property(
      S7::class_character
    )
  )
)