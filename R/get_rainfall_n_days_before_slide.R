#' Get the rainfall for N days back of the Landslide
#'
#' @export

rainfall_n_days_back = function(landslide_date, rainfall_data, n_days_back){

  # dates
  start_date =  landslide_date - n_days_back
  end_date = landslide_date

  # hours
  start_hour = 0
  end_hour = 23

  # get the rainfall
  rain_n_days_back = slice_rain(rainfall_data, start_date, start_hour, end_date, end_hour)

  # assign the landslide date
  rain_n_days_back[["dol"]] = landslide_date

  # get the time before the land
  rain_n_days_back[["days_before_event"]] = landslide_date - rain_n_days_back$date

  return(rain_n_days_back)

}
