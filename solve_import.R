## ----setup, message = FALSE, warning=FALSE-------------------------------
set.seed(24105)
library(knitr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(here)
library(purrr)
library(tidyverse)
opts_chunk$set(warning = FALSE, message = FALSE)
options(width = 100)


## ----datadownload_caaspp------------------------------------------------------
#https://stackoverflow.com/questions/41185735/downloading-multiple-files-in-r-with-variable-length-nested-urls

caaspp.results <- c("sb_ca2019_all_csv_v4", "sb_ca2018_all_csv_v3", "sb_ca2017_all_csv_v2", 
                    "sb_ca2016_all_csv_v3", "sb_ca2015_all_csv_v3")
# for (i in seq_along(caaspp.results)) {
#   url <- paste0("http://caaspp-elpac.cde.ca.gov/caaspp/researchfiles/", caaspp.results[i],".zip")
#   temp <- tempfile()
#   download.file(url, temp, mode = "wb")
#   unzip(temp, exdir = "./data")
# }


# dataimportloop_caaspp ---------------------------------------------------

# Match the filenames that contain the words "stu_assess" and put the file names in a list
caaspp.files <- grep("all_csv",  # the pattern we want to match
                     list.files("data", full.names = TRUE), # a list of files in the data dir
                     # including the path to these files
                     value = TRUE) # when we match a pattern return the value of the matched pattern

#https://stackoverflow.com/questions/12019461/rbind-error-names-do-not-match-previous-names/12019514
# create list from caaspp files
stu_test <- caaspp.files %>%
  map(., ~ read.csv(., colClasses = c("character")))