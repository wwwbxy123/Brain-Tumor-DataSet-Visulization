# UI-elements for Home tab
tabPanel(title = "Home", icon = icon("home"),
         div(class="pull-right",
             span(class='st_twitter', displayText='Tweet'),
             span(class='st_linkedin', displayText='LinkedIn'),
             span(class='st_facebook', displayText='Facebook'),
             span(class='st_email', displayText='Email')
         ),
         h1("My home page")
)