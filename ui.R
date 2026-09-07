library(shiny)
library(bslib)
library(bsicons)
library(gt)
library(reactable)
library(lubridate)

ui <- page_navbar(
  title = "Bird Lab Data Entry",

  sidebar = NULL,

  navset_tab(
    id = "top_level_tabs",
    nav_panel(
      title = "Session data",
      id = "session_data_tab",
      reactableOutput("session_data_tbl")
    ),
    nav_panel(
      title = "Banding data",
      id = "banding_data_tab",
      reactableOutput("banding_data_tbl")
    ),
    ### banding form wizard
    nav_panel(
      title = "Wizard",
      value = "wizard_container_tab",
      navset_tab(
        id = "wizard_form_tab",
        nav_panel(
          #arrange into columns
          title = "Page 1",
          card(
            selectInput(
              inputId = "net_id",
              label = "Select net",
              choices = c("A", "B", "C")
            ),
            textInput(inputId = "time", label = "Time", value = Sys.time()),
            selectInput(
              inputId = "bander",
              label = "Bander",
              choices = c("NL", "CB")
            ),
            selectInput(inputId = "code", label = "Code", choices = c("R")),
            textInput(inputId = "band_number", label = "Band #"),
            selectizeInput(
              inputId = "species_code",
              label = "Species",
              choices = c("BCCH", "INBU")
            ),
            selectInput(
              inputId = "hp_age",
              label = "HP Age",
              choices = c("ASY", "AHY", "SY", "L")
            ),
            selectInput(
              inputId = "wrp_age",
              label = "WRP Age",
              choices = c("ASY", "AHY", "SY", "L")
            ),
            textInput(inputId = "molt_location_1", label = "Molt location 1"),
            textInput(inputId = "molt_location_2", label = "Molt location 2"),
            textInput(inputId = "molt_location_3", label = "Molt location 3"),
            textInput(inputId = "molt_location_4", label = "Molt location 4"),
            selectInput(
              inputId = "sex",
              label = "Sex",
              choices = c("M", "F", "U")
            ),
            textInput(
              inputId = "skull",
              label = "Skull"
            ),
            selectInput(
              inputId = "bp",
              label = "BP",
              choices = c(0, 1, 2)
            ),
            selectInput(
              inputId = "cp",
              label = "CP",
              choices = c(0, 1, 2)
            ),
            selectInput(
              inputId = "fat",
              label = "Fat",
              choices = c(0:4)
            ),
            selectInput(
              inputId = "b_molt",
              label = "B molt",
              choices = c("0", "B", "M", "L")
            ),
            selectInput(
              inputId = "ff_molt",
              label = "FF molt",
              choices = c("0", "A")
            ),
            selectInput(
              inputId = "molt_score",
              label = "Molt score",
              choices = c("0", "A")
            ),
            sliderInput(
              inputId = "wing_chord",
              label = "Wing chord",
              min = 1,
              max = 200,
              step = 1,
              value = 55
            ),
            sliderInput(
              inputId = "tarsus",
              label = "Tarsus",
              min = 1,
              max = 200,
              step = 1,
              value = 55
            ),
            sliderInput(
              inputId = "weight",
              label = "Weight",
              min = 1,
              max = 400,
              step = 1,
              value = 80
            ),
            selectInput(
              inputId = "status",
              label = "Status",
              choices = c(NA, "300")
            ),
            textInput(
              inputId = "recapture_year",
              label = "Recapture year",
              placeholder = year(Sys.Date())
            ),
            selectInput(
              inputId = "recapture_month",
              label = "Recapture month",
              choices = month.abb
            ),
            selectInput(
              #need to look up days in recapture_month
              inputId = "recapture_date",
              label = "Recapture date",
              choices = 1:31
            ),
            textInput(
              inputId = "recapture_time",
              label = "Recapture net"
            ),
            textInput(
              inputId = "recapture_location",
              label = "Recapture location"
            ),
            textInput(
              inputId = "recapture_net",
              label = "Recapture net"
            ),
            textInput(
              inputId = "notes",
              label = "Notes"
            )
          )
        ),
        nav_panel(
          title = "Page 2",
          card(
            "Form here"
          )
        ),
        footer = card_footer(
          actionButton("select_page_1", "Previous"),
          actionButton("select_page_2", "Next")
        )
      )
    ),
    nav_spacer(),
    nav_item(
      actionButton(inputId = "open_session_creator", label = "Create session")
    ),
    nav_item(
      actionButton(inputId = "open_banding_form", label = "Band bird")
    ),
    nav_spacer(),
    nav_item(textOutput("header_session_id")),
    nav_spacer(),
    nav_item(bs_icon("arrow-repeat"))
  )
)
