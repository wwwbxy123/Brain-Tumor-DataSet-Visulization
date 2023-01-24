tabPanel(title = "Explore", icon = icon("image"), id = "explore",
         
         # link to the style.css file.
         tags$link(rel = 'stylesheet', type = 'text/css', href = 'styles.css'),
         
         sidebarLayout(fluid = FALSE,
                       sidebarPanel(
                         img(src = "logo.jpg", class="responsive-image"),
                         wellPanel(
                           # dataset
                           radioButtons(inputId ="datasetType", label = h4("Dataset:"), choices = c("Adult","Pediatric"), selected = "Adult", inline = T),
                           selectizeInput(inputId = "dataset", label ="", choices = c("A", "B", "C"), selected = 'A'),
                           conditionalPanel(
                             condition = "input.dataset == 'B'",
                             selectInput(inputId = "microarray_platform", label = h4("Platform:"), choices = c("HG-U133A","Agilent-4502A","RNA-Seq"), selected = "HG-U133A"),
                           ),
                           conditionalPanel(
                             condition = "input.dataset =='C'",
                             selectInput(inputId ="primaryCgga", label = h4("Tumor type:"), choices = c("All","Primary","Recurrent","Secondary"), selected = "Primary"),
                           ),
                           
                           # genes
                           conditionalPanel(
                             condition = "",
                             selectizeInput(inputId = "gene", label = h4("Gene:"), choices = NULL,  
                                            options = list(placeholder = "Enter gene, eg: EGFR", plugins = list('restore_on_backspace')))
                           ),
                           
                           
                           # Plot type Tab Boxplot
                           conditionalPanel(
                             condition = "input.tab1 == 1", 
                             radioButtons(inputId ="plotType", label = h4("Plot type:"), choices = c("Pre-defined","User-defined"), selected = NULL, inline = T),
                             conditionalPanel(
                               condition = "input.plotType == 'Pre-defined'",
                               selectizeInput(inputId = "plotTypeSel", label = NULL, choices = c("Histology", "Grade", "Subtype"))
                             ),
                             conditionalPanel(
                               condition = "input.plotType == 'User-defined'",
                               selectizeInput(inputId = "plotTypeUserSel", label = NULL, choices = c("Gender", "Radio_status", "Subtype"))
                             ),
                             conditionalPanel(
                               condition = "input.gene !=''",
                               checkboxInput(inputId = "removeMe", label = "Remove/arrange samples", value = FALSE),
                               conditionalPanel(
                                 condition="input.removeMe",
                                 uiOutput(outputId = "removeGp")
                               )
                             ),
                            # helpModal(modal_title ="Box plots", link = "help", help_file = includeMarkdown("contens/help.Rmd"))
                             
                           ),
                           
                         ),
                         
                         numericInput("obs", "Observations:", 10)
                       ),
                       mainPanel()
                       
         )
)