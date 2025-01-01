testthat::test_that("covert_resp_df returns a data frame", {
  resp <- '{
    "results": [
        {
            "tables": [
                {
                    "rows": [
                        {
                            "MyTable[Year]": 2010,
                            "MyTable[Quarter]": "Q1"
                        },
                        {
                            "MyTable[Year]": 2010,
                            "MyTable[Quarter]": "Q2"
                        },
                        {
                            "MyTable[Year]": 2011,
                            "MyTable[Quarter]": "Q1"
                        }
                    ]
                }
            ]
        }
    ]
}'
  df <- convert_resp_df(resp)
  expect_is(df, "data.frame")
  expect_equal(df, data.frame(
    Year = c(2010, 2010, 2011),
    Quarter = c("Q1", "Q2", "Q1")
  ))
})
