
## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "https://cran.wu.ac.at/"
       options(repos=r)
   })

## options(help_type = "html")
options(scipen = 99, digits = 3)
options(max.print = 9999)
options(stringsAsFactors = FALSE)
options(width = 75)
options(menu.graphics=FALSE)

options(devtools.name = "Oliver Reiter")
options(devtools.desc.author = "person(\"Oliver\", \"Reiter\", email = \"oliver_reiter@gmx.at\", role = c(\"aut\", \"cre\"))")

utils::rc.settings(ipck=TRUE)

.olienv <- new.env()
 

.olienv$sshhh <- function(a.package) {
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}
 
.olienv$auto.loads <-c("data.table", "devtools", "ormisc")
 
attach(.olienv)

if(interactive()) {
    invisible(sapply(auto.loads, sshhh))
    message("=> Custom .Rprofile with packages loaded ...\n")
}
