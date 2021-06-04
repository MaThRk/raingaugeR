#' Match station names of data with station name of excel file
#'
#' @importFrom stringr str_replace
#'
#' @export

clean_station_data_names = function(station_names_from_files){

  # remove the underscores and introduce spaces
  new_names = gsub("_", " ", station_names_from_files)

  #
  new_names = as.data.frame(new_names)
  names(new_names) = c("name")

  # do some manual renaming
  names_data_final = new_names %>%
    mutate(
      name = str_replace(name, ".*Eisack.*", "Eisack - Sterzing"),
      name = str_replace(name, ".*Antholz.*", "Antholz - Obertal"),
      name = str_replace(name, ".*Eyrs.*", "Eyrs - Laas"),
      name = str_replace(name, ".*Meran.*", "Meran - Gratsch"),
      name = str_replace(name, ".*Oberplanitzing.*", "Oberplanitzing - Kaltern"),
      name = str_replace(name, ".*Seiser Alm.*", "Seiser Alm - Zallinger"),
      name = str_replace(name, ".*St.Walburg.*", "St.Walburg - Zoggler Stausee")
    )  %>% pull(name)

  return(names_data_final)

}



