shinyUI(  
  navbarPage(title = strong("Title"), windowTitle = "Window Title", 
             fluid = TRUE, footer = includeHTML("contents/footer.html"), id = "nav",
             
             source("tabs/home.R", local = TRUE)$value,
             source("tabs/explore.R", local = TRUE)$value,
             source("tabs/about.R", local = TRUE)$value,
             source("tabs/news.R", local = TRUE)$value
  )
)
