library(shiny)
library(tidyverse)
library(arrow)
library(glue)
library(gt)
library(reactable)

fake_banding_data <- open_dataset("test_data/banding_data")

fake_session_data <- open_dataset("test_data/session_data") |>
  arrange(session_start_time)

server <- function(input, output, session) {
  session_data_reader <- fetch_session_data(session = session)

  session_data_reactive <- reactive({
    session_data_reader() |>
      arrange(desc(session_start_time))
  })

  #set active session to NA
  active_session <- reactiveVal(NA)

  #create shell for session data
  session_data <- reactiveValues(
    session_id = NA,
    session_start_time = NA,
    session_location = NA,
    session_nets = NA
  )

  session_modal <- renderUI({
    modalDialog(
      title = "Create session",
      textInput(inputId = "session_id", label = "Name", value = "Test session"),
      textInput(
        inputId = "session_start_time",
        label = "Start time",
        value = Sys.time()
      ),
      selectizeInput(
        inputId = "session_location",
        label = "Location",
        choices = c("Hays Woods", "Upper St. Clair", "C")
      ),
      selectizeInput(
        inputId = "session_nets",
        label = "Nets",
        choices = c("A", "B", "C"),
        selected = "A",
        multiple = TRUE
      ),
      actionButton(inputId = "create_session", label = "Create session"),
      footer = modalButton("Close"),
      easyClose = TRUE
    )
  })

  observeEvent(1, {
    showModal(session_modal)
  })

  observeEvent(input$open_session_creator, {
    showModal(session_modal)
  })

  observeEvent(input$create_session, {
    session_data$session_id <- input$session_id
    session_data$session_start_time <- ymd_hms(input$session_start_time)
    session_data$session_location <- input$session_location
    session_data$session_nets <- input$session_nets

    new_session_df <- tibble(
      session_id = session_data$session_id,
      session_start_time = session_data$session_start_time,
      session_location = session_data$session_location,
      session_nets = str_c(session_data$session_nets, collapse = ", ")
    )

    active_session(input$session_id) #set active session upon creation

    write_parquet(
      new_session_df,
      glue("test_data/session_data/{session_data$session_id}.parquet")
    )

    removeModal()
  })

  observeEvent(1, {
    updateTextInput(
      inputId = "session_start_time",
      session = session,
      value = Sys.time()
    )
  })

  session_data_tbl_selected <- reactive(getReactableState(
    "session_data_tbl",
    "selected"
  ))

  observeEvent(session_data_tbl_selected(), {
    x <- session_data_reactive() |>
      collect() |>
      filter(row_number() == session_data_tbl_selected()) |>
      pull(session_id)

    active_session(x)
  })

  output$session_data_tbl <- renderReactable({
    session_data_reactive() |>
      collect() |>
      reactable(selection = "single", onClick = "select")
  })

  output$header_session_id <- renderText({
    glue("Session {active_session()}")
  })

  output$banding_data_tbl <- renderReactable({
    fake_banding_data |>
      collect() |>
      reactable()
  })
}
