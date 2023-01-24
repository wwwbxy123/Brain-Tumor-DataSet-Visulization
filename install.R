# 1) Restart R
# 2) Run install_gliovis(), included below, to install

#######################################################

install_myApp <- function() {
  
  if (getRversion() < '3.1.1') stop("GlioVis requires R version 3.1.1 or greater.")
  
  msg <- "Note: this will install or update packages needed to run this app. Do you want to continue?"
  continue <- select.list(choices = c("Yes", "No"), title = msg, graphics = FALSE)
  if (continue == "No") {
    message("Installation canceled by user.")
    return(invisible(NULL))
  }
  
  # install needed packages from CRAN
  pkg <- c("shiny")
  
  new.pkg <- pkg[!(pkg %in% installed.packages())]
  
  if (length(new.pkg)) {
    install.packages(new.pkg, dependencies=TRUE)
  }
  
  update.packages(pkg[!(pkg %in% new.pkg)])
  
  # install needed packages from Bioconductor
  bioc <- c("GSVA","limma","DOSE","clusterProfiler")
  if(!(bioc %in% installed.packages())){
    source("http://bioconductor.org/biocLite.R")
    biocLite(bioc) 
  }
  
  # install needed packages from Github
  devtools::install_github("jokergoo/ComplexHeatmap")
  # devtools::install_github(c("GuangchuangYu/DOSE", "GuangchuangYu/clusterProfiler"))
  
  message("\n All set. \n You might need to restart R before using GlioVis \n")
  return(invisible(NULL))
}

install_myApp()
