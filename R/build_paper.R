build_birthtiming <- function(){
  knitr::knit(paste0(.libPaths(), "/birthtiming/paper/paper.Rmd"))
}

open_paper_dir <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  if(tolower(os)=="windows"){
    shell(paste0("explorer ",
                 stringr::str_replace_all(.libPaths(), "/", "\\\\\\" ),
                 "\\birthtiming\\paper"), intern=TRUE)
  } else if (tolower(os)=="osx"){
    system2("open", paste0(.libPaths(), "/birthtiming/paper"))
  }
}

browse_paper <- function(){
  browseURL("https://clanfear.github.io/birthtiming/inst/paper/paper.html")
}

browse_compendium <- function(){
  browseURL("https://github.com/clanfear/birthtiming/")
}

browse_presentation <- function(){
  browseURL("https://clanfear.github.io/birthtiming/inst/presentation/presentation.html")
}
