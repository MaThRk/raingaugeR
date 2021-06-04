#' Get Raingauge Station information
#'
#' Get the information for the raingauages from the excel file
#'
#' @importFrom readxl read_xlsx

#' @export

get_station_information = function(
  info_path = "/mnt/CEPH_PROJECTS/Proslide/SubDailyStations_WISKI.xlsx"
){

  # read file
  df = readxl::read_xlsx(info_path)

  # make all column names (lower case only?)
  names = names(df) %>% tolower()

  # rename the time resolution column
  idx = which(grepl(pattern = ".*time res.*", names, ignore.case = T))
  names[[idx]] = gsub(pattern = "\\s", replacement = "_", x = names[[idx]])
  names = gsub(pattern = "\\((.*)\\)", replacement = "\\1", names)

  df = setNames(df, names)

  # return the dataframe
  return(df)

}
