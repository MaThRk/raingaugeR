#' Extract rainfall for a station between two timestamps
#'
#' @export
#'

slice_rain = function(rainfall_data = NULL,
                                start_date = NULL,
                                start_hour = 0,
                                end_date = NULL,
                                end_hour = 23) {

  # numeric hour to easy subsetting
  rainfall_data[["hour_int"]] = as.numeric(gsub(pattern = "(^\\d{2}).*", "\\1",
                                                as.character(rainfall_data$hour)))

  # genertate sequence of days between start_day and end day
  days_sequence = seq(start_date + 1, end_date - 1, by="day")
  days_between = rainfall_data[rainfall_data$date %in% days_sequence, ]

  # start day
  start_day = rainfall_data[rainfall_data$date == start_date &
                              rainfall_data$hour_int > start_hour, ]

  # end day
  end_day = rainfall_data[rainfall_data$date == end_date &
                              rainfall_data$hour_int < end_hour, ]


  # bind them together
  df = rbind(start_day, days_between, end_day)

  return(df)


}
