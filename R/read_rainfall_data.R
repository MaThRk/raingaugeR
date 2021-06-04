#' Read the station rainfall data
#'
#' @importFrom stringdist stringsim
#'
#' @param station_data_path Path to the directory containing the \code{txt} files
#' for the rainfall data from the WISKI database
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

read_rainfall = function(station_data_path = "/mnt/CEPH_PROJECTS/Proslide/HourlyPrecData/Checked_HourlyRR",
                         station = NULL,
                         only.names = FALSE) {
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

  if (only.names) {
    return(station_names)
  }

  # read in the data into a list
  if (is.null(station)) {
    station_data = vector(mode = "list", length = length(station_names))
    for (i in seq_along(station_data)) {
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
      station_data[[i]] = d
    }

    # set the names
    names(station_data) = station_names

    # return a named list with the data for each location being a datframe
    return(station_data)

  } else{

    if (!station %in% station_names) {
      warning("The station you want could not be found in the list of station names")
    }

    # which string is most similar?
    sim = stringdist::stringsim(station, station_names)
    idx = which.max(sim)
    yesno = readline(prompt = paste0("Did you meant: ", station_names[[idx]], "[Yy|Nn] "))

    if (grepl("y", yesno, ignore.case = T)) {
      station = station_names[[idx]]
    } else{
      stop("No station selected...")
    }

    # read this one station
    df = read.table(stations_paths[[idx]])
    names(df) = names_data

    return(df)

  }
}
