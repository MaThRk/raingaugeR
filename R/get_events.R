#' Get the events for a continous series of rainfall

#' @param precip Vector with rainfall-measurements
#' @param n_dry = number of hours with rainfall below \code{min_thresh} to separate two
#' rainfall-events
#' @param min_thresh minimum rainfall per hour to be considered rainfall and no measurement error

get_events = function(precip = NULL,
                      n_dry = NULL,
                      min_thresh = NULL) {
  event_counter = 1
  events = vector(length = length(precip))

  # for the current hour
  i = 1
  while (i < length(precip)) {

    # 1
    cat("\r", i)

    # if the rain on that day is greater than the threshold go in the "wet"-loop
    if (precip[[i]] >= min_thresh & !is.na(precip[[i]])) {

      # set the event-number on that day
      events[[i]] = event_counter

      # for all the later hours check how long in rained
      dry_period = 0

      for (j in (i + 1):length(precip)) {

        # 2
        cat("\r", j)

        # if in rained in the next hour
        if (precip[[j]] >= min_thresh & !is.na(precip[[j]])) {

          # if moving from a dry hour to a wet one --> check how many hours it had not rained
          if (dry_period > n_dry) {
            events[(j - dry_period):(j - 1)]  = NA
            event_counter = event_counter + 1
            i = j
            break # exit the wet loop

          } else{

            # set all the dry hours to the event number as the dry period was shorter than the minimum
            events[(j - dry_period):(j - 1)]  = event_counter

            # set the event-number
            # events[[j]]  = event_counter

            # reset the dry_period
            dry_period = 0

            # set i to j in case we are exiting this wet loop
            i = j

          }

        } else{
          # if a wet hour hit on a dry hour
          dry_period = dry_period + 1

          i = j

        }
      }
    } else{
      # -------------------------------------------------------------------------
      events[[i]] = NA
      i = i + 1
    }
  }
  return(events)
}
