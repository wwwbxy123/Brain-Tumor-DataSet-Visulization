# UI-elements for News tab
tabPanel(title = "News", icon = icon("newspaper"),
         #panel_div(class_type = "primary",panel_title = "News",content = includeHTML("contents/news.html")),
         includeHTML("contents/news.html")
)

