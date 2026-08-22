library(shiny)
library(tidyverse)

server <- function(input, output, session) {
  session_modal <- renderUI({
    modalDialog(
      title = "Create session",
      textInput(inputId = "session_id", label = "Name"),
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
        multiple = TRUE
      ),
      footer = actionButton(inputId = "create_session", label = "OK")
    )
  })

  observeEvent(1, {
    showModal(session_modal)
  })

  observeEvent(input$create_session, {
    session_data$session_id <- input$session_id
    session_data$session_start_time <- input$session_start_time
    session_data$session_location <- input$session_location
    session_data$session_nets <- input$session_nets

    removeModal()
  })

  observeEvent(1, {
    updateTextInput(
      inputId = "session_start_time",
      session = session,
      value = Sys.time()
    )
  })

  session_data <- reactiveValues(
    session_id = NA,
    session_start_time = NA,
    session_location = NA,
    session_nets = NA
  )

  output$session_data_tbl <- renderTable({
    x <- tibble(
      session_id = session_data$session_id,
      session_start_time = session_data$session_start_time,
      session_location = session_data$session_location,
      session_nets = str_c(session_data$session_nets, collapse = ", ")
    )

    x
  })
}
