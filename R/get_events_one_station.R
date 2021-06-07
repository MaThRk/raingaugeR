#' Get rainfall events for one station
#'
#' For one station get all the rainfall-events that occurred in the recording
#'
#' @param station a dataframe containing the rainfall measurements for one station
#' @param n_dry the time with no rain that splits two consecutive rainfall events.
#' @param min_thresh the minimum amount of daily rainfall which is considered to be
#' not due to the insensitivity of the station or some other influences?

get_events_one_station = function(station = NULL,
                                  n_dry = NULL, # set all arguments to null to enforce thinking about
                                  min_thresh = NULL,
                                  method=1){ # them each time I call the function


  # cehck input
  if(is.null(station)){
    stop("You must provide a station for which to calculate the rainfall events")
  }

  if(is.null(n_dry)){
    stop("You must provide a period of time that separates two rainfall events")
  }

  if(is.null(min_thresh)){
    stop("You must provide a minimum threshold under which the rainfall is not considered to be
         due to measurements")
  }

  # get the rainfall
  precip = station$precip

  # get the events
  if(method == 1){
    # get the rainfall events based on fixed intervals
    events = get_events(precip, n_dry, min_thresh)
    # put them in the dataframe
    station[["events"]] = events

  }else if(method == 2){
    # get the events with a rolling average (returns a dataframe witht the rolling average and the events)
    events_ra = get_events_ra(precip, 24, min_thresh)
    # put them in the dataframe
    station[["events_ra"]] = events_ra
  }

  station = cbind(station, events_ra)

  # return the dataframe
  return(station)

}
