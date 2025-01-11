dashboard <- S7::new_class("dashboard",
  parent = workspace_contained_item,
  properties = list(
    item_type = S7::new_property(
      S7::class_character,
      setter = function(self) {
        if (!is.null(self@item_type)) {
          rlang::abort("@item_type is read-only", call. = FALSE)
        }
        self@item_type <- "dashboard"
        self
      }
    )
  )
)