fetch_session_data <- function(x = "test_data/session_data", session) {
  reactiveFileReader(
    1000,
    session,
    x,
    open_dataset
  )
}
