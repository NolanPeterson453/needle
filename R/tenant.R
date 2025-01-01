#' The class constructor of class workspace_contained
#'
#' `workspace_contained` is used to instatiate a new
#' workspace contained object. Used primarly as a parent class to objects
#' contained in Fabric workspaces.
#'
#' @param id GUID input. The id tenant.
#' @param name string input. The name of the workspace contained object
#' @param workspace_id GUID input. The id of the contianing workspace.
#' @param workspace_name string input. The name of the containing workspace.
#' @returns A an object of class workspace_contained.
#'
tenant <- S7::new_class("tenant",
  properties = list(
    id <- S7::new_property(
      S7::class_character
    ),
    auth_method <- S7::new_property(
      S7::class_character,
      validator = function(self){
        if (!(self@auth_method %in% c("Interactive", "File"))) {
          "@auth_method must be Interactive or File"
        }
      }
    ),
    credentials <- S7::new_property(
      S7::class_list
    ),
    auth_token <- S7::new_property(
      S7::class_character,
      getter = function(self) {
        auth_token <- get_auth_token(self@auth_method)
        return(auth_token)
      }
    )
  )
)