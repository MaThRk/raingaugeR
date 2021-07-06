#' Get Raingauge Station information
#'
#' Get the information for the raingauages from the excel file
#'
#' @importFrom readxl read_xlsx

#' @export

get_station_information = function(info_path = "/mnt/CEPH_PROJECTS/Proslide/SubDailyStations_WISKI.xlsx",
                                   station = NULL) {

  # read file
  df = readxl::read_xlsx(info_path)

  # make all column names (lower case only?)
  names = names(df) %>% tolower()

  # rename the time resolution column
  idx = which(grepl(pattern = ".*time res.*", names, ignore.case = T))
  names[[idx]] = gsub(pattern = "\\s",
                      replacement = "_",
                      x = names[[idx]])
  names = gsub(pattern = "\\((.*)\\)", replacement = "\\1", names)

  df = setNames(df, names)

  # get the names from the files for each station
  station_names_files = read_rainfall(only.names = T)
  df = merge(df, station_names_files, by.x="name", by.y="names_matching_excel")

  if (is.null(station)) {

    # turn the dataframe into an object of class sf
    station_sf = st_as_sf(df, coords=c("easting", "northing"), crs=32632)
    return(station_sf)

  } else{

    # subset the dataframe for that station
    df_subset = df[df$name %in% station,]

    # make sf object
    station_sf = st_as_sf(df_subset, coords=c("easting", "northing"), crs=32632)

    return(station_sf)

  }
}
