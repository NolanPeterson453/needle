semantic_model <- S7::new_class("semantic_model",
  parent = workspace_contained_item,
  properties = list(
    item_type = S7::new_property(
      S7::class_character,
      setter = function(self) {
        if (!is.null(self@item_type)) {
          rlang::abort("@item_type is read-only", call. = FALSE)
        }
        self@item_type <- "semantic model"
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
