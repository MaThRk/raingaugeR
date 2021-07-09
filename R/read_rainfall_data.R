#' Read the station rainfall data
#'
#' This function is called for each landslide. Each landslide can have a vector of stations, as returned by a
#' \code{get_station_by_*}-function. The start date must be a vector of the same length as the \code{station}-vector.
#' Same is true for the \code{end_date}-vector.
#'
#'
#' @importFrom stringdist stringsim
#'
#' @param station_data_path Path to the directory containing the \code{txt} files
#' for the rainfall data from the WISKI database
#' @param station If you want only the data for one station
#' @param only.names If TRUE, returns a dataframe with only the names from the stations.
#' The two columns are the names from the file and the name matching the excel file.
#'
#' @return A list. Each element is a datafame and contains the data for that station.
#' the name of each list-element is the name of the station
#'
#' @export
#'
#' @examples
#' df = read_rainfall(<path_to_data>)[[1]]
#' head(df)
#'         date     hour precip m_measure
#' 1 2002-10-29 01:00:00      0        12
#' 2 2002-10-29 02:00:00      0        12
#' 3 2002-10-29 03:00:00      0        12
#' 4 2002-10-29 04:00:00      0        12
#' 5 2002-10-29 05:00:00      0        12
#' 6 2002-10-29 06:00:00      0        12
#' @md

read_rainfall = function(station = NULL,
                         station_data_path = "/mnt/CEPH_PROJECTS/Proslide/HourlyPrecData/Checked_HourlyRR",
                         only.names = FALSE,
                         start_date = NULL,
                         end_date = NULL) {

  # check if data-path exists
  if (!dir.exists(station_data_path)) {
    stop("The path to the directory of the data does no exist...")
  }

  # list the files
  stations_paths = list.files(station_data_path, full.names = T)

  # the names for the columns
  names_data = c("date", "hour", "precip", "n_measure")

  # get the names
  station_names = gsub(".*HourlyRR\\/(.*).txt$", "\\1", stations_paths, perl = T)
  # get the names matching the excel file
  correct_names = clean_station_data_names(station_names)
  names_matching_excel = correct_names

  df_names = data.frame(name_from_file = station_names,
                        names_matching_excel = correct_names)

  # if only names
  if (only.names) {
    return(df_names)
  }

  # read in the data into a list
  if (is.null(station)) {
    station_data = vector(mode = "list", length = length(station_names))


    for (i in seq_along(station_data)) {
      station_list = vector("list", length = 2)
      station_list = setNames(station_list, c("data", "info"))

      # read the data
      d = read.table(stations_paths[[i]])

      # print message
      cat(paste0(
        "Read (",
        i,
        "/",
        length(station_names),
        "): ",
        station_names[[i]]
      ))
      cat(paste0(", ", nrow(d), " lines\n"))

      # check_rainfall_data(d)
      names(d) = names_data
      # assumes that the data column is always the first column
      d[, 1] = as.Date(d[, 1])

      station_list[[1]] = d

      # get the additional information from the excel file
      station_name_excel = correct_names[[i]]
      add_info = get_station_information(station = station_name_excel)
      station_list[[2]] = add_info

    }

    # set the names
    names(station_data) = station_names

    # return a named list with the data for each location being a datframe
    return(station_list)

  } else{

    # for all the stations
    all_stations = vector("list", length = length(station))
    names(all_stations) = station

    i = 1 # dont want to change code anymore hugh...

    # for each station for each landslide
    for (stat in station) {

      if (!stat %in% station_names) {

        warning("The station you want could not be found in the list of station names")
        # which string is most similar?
        sim = stringdist::stringsim(stat, station_names)
        idx = which.max(sim)

        # idx = which(grepl(stat, station_names))
        # stat = station_names[[idx]]

        # read this one station
        df = read.table(stations_paths[[idx]])
        names(df) = names_data

        # assumes that the data column is always the first column
        df[, 1] = as.Date(df[, 1])

        # slice the data based on the input dates
        df = slice_rain(df, start_date = start_date,
                        end_date = end_date)


        # get the additional information from the excel file
        station_name_excel = correct_names[[idx]]
        add_info = get_station_information(stat = station_name_excel)
        add_info[["data"]] = list(data = df)

        all_stations[[i]]  = station_list

        i = i + 1

      }else{

        idx = which(station_names == stat)

        # read this one station
        df = read.table(stations_paths[[idx]])
        names(df) = names_data

        # assumes that the data column is always the first column
        df[, 1] = as.Date(df[, 1])

        # if the date of the landslide does not correspond to the dates in the stations
        date_unmatch = start_date[[i]] < min(df$date) || end_date[[i]] > max(df$date) || start_date[[i]] > max(df$date) || end_date[[i]] < min(df$date)
        if(date_unmatch){
          df = list(data_avail = FALSE,
                          dol = start_date[[i]],
                          start_date_station = min(df$date),
                          end_date_station = max(df$date))

        } else{
          # slice the data based on the input dates
          df = slice_rain(df, start_date = start_date[[i]],
                          end_date = end_date[[i]])
          df = list(df, data_avail = TRUE)
        }




        # get the additional information from the excel file
        station_name_excel = correct_names[[idx]]
        add_info = get_station_information(station = station_name_excel)
        add_info[["data"]] = list(data = df)

        all_stations[[i]]  = add_info
        i = i + 1
      }
    }


    return(all_stations)

  }
}
