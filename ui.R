library(shiny)
library(bslib)

ui <- page_navbar(
  title = "Bird Lab Data Entry",

  sidebar = NULL,

  navset_tab(nav_panel(title = "Session data", tableOutput("session_data_tbl")))
)
