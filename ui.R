library(shiny)
library(bslib)
library(bsicons)

ui <- page_navbar(
  title = "Bird Lab Data Entry",

  sidebar = NULL,

  navset_tab(nav_panel(
    title = "Session data",
    tableOutput("session_data_tbl")
  )),
  nav_spacer(),
  nav_item(textOutput("header_session_id")),
  nav_item(bs_icon("arrow-repeat"))
)
