testthat::test_that("get_id for semantic model", {
  mock_model <- semantic_model(
    name <- "SemanticModel Name 1",
    workspace_id <- "cfafbeb1-8037-4d0c-896e-a46fb27ff229"
  )
  mock_resp <- function(req) {
    mock_resp_data <- '
   {
  "value": [
    {
      "id": "3546052c-ae64-4526-b1a8-52af7761426f",
      "displayName": "SemanticModel Name 1",
      "description": "A semantic model description.",
      "type": "SemanticModel",
      "workspaceId": "cfafbeb1-8037-4d0c-896e-a46fb27ff229"
    }
  ]
}'
    httr2::response(
      status_code = 200,
      url = "https://api.fabric.microsoft.com/v1/workspaces/cfafbeb1-8037-4d0c-896e-a46fb27ff229/semanticModels", # nolint
      method = "GET",
      headers = list(
        Authorization <- "Bearer mock_auth_token" # nolint
      ),
      body = raw(mock_resp_data)
    )
  }
  result <- httr2::with_mocked_responses(
    mock_resp,
    mock_model@get_id(auth_token = "mock_auth_token")
  )
  result |>
    expect_guid() |>
    testthat::expect_equal("3546052c-ae64-4526-b1a8-52af7761426f")
}
)

testthat::test_that("get_id for report", {
  mock_report <- report(
    name <- "report Name 1",
    workspace_id <- "cfafbeb1-8037-4d0c-896e-a46fb27ff229"
  )
  mock_resp <- function(req) {
    mock_resp_data <- '
   {
  "value": [
    {
      "id": "3546052c-ae64-4526-b1a8-52af7761426f",
      "displayName": "Report Name 1",
      "description": "A report description.",
      "type": "Report",
      "workspaceId": "cfafbeb1-8037-4d0c-896e-a46fb27ff229"
    }
  ]
}'
    httr2::response(
      status_code = 200,
      url = "https://api.fabric.microsoft.com/v1/workspaces/cfafbeb1-8037-4d0c-896e-a46fb27ff229/reports", # nolint
      method = "GET",
      headers = list(
        Authorization <- "Bearer mock_auth_token" # nolint
      ),
      body = raw(mock_resp_data)
    )
  }
  result <- httr2::with_mocked_responses(
    mock_resp,
    mock_report@get_id(auth_token = "mock_auth_token")
  )
  result |>
    expect_guid() |>
    testthat::expect_equal("3546052c-ae64-4526-b1a8-52af7761426f")
}
)