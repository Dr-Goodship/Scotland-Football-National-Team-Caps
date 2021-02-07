library(rvest)
library(dplyr)
library(purrr)

page <- LETTERS[seq( from = 1, to = 26 )]

urls <- list()

for (i in 1:length(page)) {
  url<- paste0("https://www.fitbastats.com/scotland/player_list_az.php?page=",page[i])
  urls[[i]] <- url
}

tbl <- list()

#j <- 1

for (j in seq_along(urls)) {
  
  tbl[[j]] <- urls[[j]] %>%
    read_html() %>%
    html_table() 
  #bind_rows()
  
  #tbl[[j]]$j <- j
  #j <- j+1 
}

tbl1 <- do.call(rbind, tbl)

result <- list()

result <- purrr::keep(tbl1, ~ ncol(.x) == 7)

final <- do.call(rbind, result)

final01 <- distinct(final)

final01$From <- substr(final01$`Played Between`, start = 1, stop = 9)
final01$To <- substr(final01$`Played Between`, start = 10, stop = 19)

str(final01)

setwd('/Users/paulgoodship/Documents/Data Projects/Football/Scotland')
getwd()
write.csv(final01, 'Scotland_all_data.csv')
getwd()
