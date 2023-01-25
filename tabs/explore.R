tabPanel(title = "Explore", icon = icon("image"), id = "explore",
         
         # link to the style.css file.
         tags$link(rel = 'stylesheet', type = 'text/css', href = 'styles.css'),
         
         sidebarLayout(fluid = FALSE,
                       sidebarPanel(
                         img(src = "logo.jpg", class="responsive-image"),
                         wellPanel(
                           # dataset
                           radioButtons(inputId ="datasetType", label = h4("Dataset:"), choices = c("Adult","Pediatric"), selected = "Adult", inline = T),
                           selectizeInput(inputId = "dataset", label ="", choices = c("A", "B", "C", "A", "B", "C", "D", "A", "B", "C", "D"), selected = 'A'),
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
                             condition = "input.tabCorr != 'corrMany' & input.tab1 != 5 & input.tab1 != 8",
                             selectizeInput(inputId = "gene", label = h4("Gene:"), choices = c("A", "B", "C", "D", "A", "B", "C", "D", "A", "B", "C", "D", "A", "B", "C", "D"),  
                                            options = list(placeholder = "Enter gene, eg: A", plugins = list('restore_on_backspace')))
                           ),
                           
                           
                           # Plot type Tab Boxplot
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
                             
                           # Statistic
                           wellPanel( 
                             h4("Statistic:"),
                             checkboxInput(inputId = "statSummary", label = "Summary statistics", value = FALSE),
                             checkboxInput(inputId = "tukeyHSD", label = "Tukey's HSD", value = FALSE),
                             checkboxInput(inputId = "tTest", label = "Pairwise t tests", value = FALSE)
                           ),
                           
                           # Plot options
                           wellPanel( 
                             h4("Plot options:"),
                             p(style = "background-color: #8ABBD7; padding-left:10px; border: 1px solid #E3E3E3;",
                               strong("Plot size")),
                             div(class="row",
                                 div(class="col-xs-6",
                                     numericInput("plot_height", label = "Height (pixels):", min = 100, max = 2000, step = 50, value = 400)
                                 ),
                                 div(class="col-xs-6",
                                     numericInput("plot_width", label = "Width (pixels):", min = 100, max = 2000, step = 50, value = 500)
                                 )
                             ),
                             p(""),      
                             p(style = "background-color: #8ABBD7; padding-left:10px; border: 1px solid #E3E3E3;",
                               strong("Points appearance")),
                             div(class="row",
                                 div(class="col-xs-6",
                                     numericInput(inputId = "point_size",label = "Size", 
                                                  value = 2, min = 0, max = 5, step = 0.5)
                                 ),
                                 div(class="col-xs-6",
                                     numericInput(inputId = "alpha",label = "Transparency",
                                                  value = 0.5, min = 0, max = 1, step = 0.1)
                                 )
                             ),
                             div(class="row",
                                 div(class="col-xs-6",
                                     selectInput("colorP", "Color by:", choices = "None")
                                 ),
                                 div(class="col-xs-6",
                                     selectInput("shapeP", "Shape by:", choices = "None")
                                 )
                             ),
                             p(style = "background-color: #8ABBD7; padding-left:10px; border: 1px solid #E3E3E3;",
                               strong("Axis labels")),
                             div(class="row",
                                 div(class="col-xs-6",
                                     textInput(inputId = "myXlab", label = "X-axis label:", value = "")
                                 ),
                                 div(class="col-xs-6",
                                     numericInput(inputId = "xaxisLabelAngle",label = "X-axis angle",
                                                  value = 30, min = 0, max = 90, step = 15)
                                 )
                             ),
                             textInput(inputId = "myYlab", label = "Y-axis label:", value = "mRNA expression (log2) \n"),
                             div(class="row",
                                 div(class="col-xs-6",
                                     numericInput(inputId = "axis_text_size",label = "Axis text (pt)",
                                                  value = 12, min = 0, max = 20, step = 1)
                                 ),
                                 div(class="col-xs-6",
                                     numericInput(inputId = "axis_title_size",label = "Axis title (pt)",
                                                  value = 12, min = 0, max = 20, step = 1)
                                 )
                             ),
                             p(""),                            
                             p(style = "background-color: #8ABBD7; padding-left:10px; border: 1px solid #E3E3E3;",
                               strong("Miscellaneous")),
                             checkboxInput(inputId = "scale", label = "Scale y axis", value = FALSE),
                             checkboxInput(inputId = "bw", label = "White background", value = TRUE),
                             checkboxInput(inputId = "colBox", label = "Color box", value = FALSE)
                           )
                         ),
                         
                         # Allow the user to set the height and width of the plot download.
                         wellPanel( 
                           h4("Download:"),
                           selectInput(inputId = "downloadPlotFileType", label = strong("Select download file type"),
                                       choices = list("PDF"  = "pdf", "TIFF"  = "tiff", "PNG"  = "png", "BMP"  = "bmp", "JPEG" = "jpeg")
                           ),
                           strong("Set download image dimensions"),
                           helpText("(units are inches for PDF, pixels for all other formats)"),
                           div(class="row",
                               div(class="col-xs-6",
                                   numericInput(inputId = "downloadPlotHeight", label = "Height (inches)", 
                                                value = 7, min = 1, max = 100)
                               ),
                               div(class="col-xs-6",
                                   numericInput(inputId = "downloadPlotWidth", label = "Width (inches)", 
                                                value = 7, min = 1, max = 100)
                               )
                           ),
                           conditionalPanel(
                             condition = "input.downloadPlotFileType != 'pdf'",
                             div(class="row",
                                 div(class="col-xs-6",
                                     numericInput(inputId = "downloadPlotRes", label = "Resolution (ppi)", 
                                                  value = 72, min = 72, max = 600)
                                 )
                             )
                           ),
                           br(),
                           
                           #Download buttons
                           conditionalPanel(
                             condition = "input.tab1 == 1",
                             downloadButton(outputId = "downloadPlot", label = "Download", class= "btn-primary")
                           ),
                           conditionalPanel(
                             condition = "input.tab1 == 2 & input.tabSurv == 'km'",
                             downloadButton(outputId = "downloadsurvPlot", label = "Download", class= "btn-primary")
                           ),
                           conditionalPanel(
                             condition = "input.tab1 == 2 & input.tabSurv == 'hr'",
                             downloadButton(outputId = "downloadkmPlot", label = "Download", class= "btn-primary")
                           ),
                           conditionalPanel(
                             condition = "input.tab1 == 3 & input.tabCorr == 'corrTwo'",
                             downloadButton(outputId = "downloadcorrPlot", label = "Download", class= "btn-primary")
                           ),
                           conditionalPanel(
                             condition = "input.tab1 == 3 & input.tabCorr == 'corrMany'",
                             downloadButton(outputId = "downloadpairsPlot", label = "Download", class= "btn-primary")
                           )
                         ),
                         
                         numericInput("obs", "Observations:", 10)
                       ),
                       mainPanel()
                       
         )
)