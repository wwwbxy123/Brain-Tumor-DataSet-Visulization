library(shiny)

options(shiny.usecairo=TRUE)

panel_div <-function(class_type, panel_title, content) {
  HTML(paste0("<div class='panel panel-", class_type,
              "'> <div class='panel-heading'><h3 class='panel-title'>", panel_title,
              "</h3></div><div class='panel-body'>", content,  "</div></div>", sep=""))
}


############################################################################
############## Help popup (https://gist.github.com/jcheng5/5913297)  #######
############################################################################
## https://groups.google.com/forum/#!searchin/shiny-discuss/helpPopup/shiny-discuss/ZAkBsL5QwB4/vnmbT47uY7gJ

helpModal <- function(modal_title, link, help_file) {
  sprintf("<div class='modal fade' id='%s' tabindex='-1' role='dialog' aria-labelledby='%s_label' aria-hidden='true'>
          <div class='modal-dialog'>
          <div class='modal-content'>
          <div class='modal-header'>
          <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
          <h4 class='modal-title' id='%s_label'>%s</h4>
          </div>
          <div class='modal-body'>%s</div>
          </div>
          </div>
          </div>
          <i title='Help' class='fa fa-question-circle' data-toggle='modal' data-target='#%s'></i>",
          link, link, link, modal_title, help_file, link) %>%
    enc2utf8 %>% HTML
}