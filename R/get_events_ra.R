#' Get events based on rolling average
#'
#' @param n Number of hours for the rolling average



get_events_ra = function(precip,
                         n = 24,
                         min_thresh){


  # calculate the rolling averge
  ra = vector(length = length(precip))

  for (i in seq_along(precip)) {
    # for the first n days there is no rolling average
    if (i < n) {
      ra[[i]] = NA
    } else{
      vals = precip[(i - n):i]
      mean_vals = mean(vals, na.rm=TRUE)
      ra[[i]] = mean_vals

    }
  }

  events_ra = separate_events_ra(ra, min_thresh)

  df = data.frame(events_ra, ra)
  names(df) =c("events_ra", paste0("rolling_average_", n, "h"))

  return(df)

}
