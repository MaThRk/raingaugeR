#' function to seperate rainfall-events for rolling average

#' @param ra Vector with rolling averages of rainfall data
#' @param min_thresh minimum value for an hour to be considered wet
#'
separate_events_ra = function(ra, min_thresh){
  events = vector(length = length(ra))
  event_counter = 1
  i = 1
  while(i <= length(ra)) {

    print(paste0("i: ", i))


    if(is.na(ra[[i]])){
      events[[i]] = NA
      i = i +1
      if(i == length(ra)){
        return(events)
      }
    }

    if(ra[[i]] < min_thresh & !is.na(ra[[i]])){
      events[[i]]  = NA
      i = i + 1

    }else{
      l = 1
      # go in the wet days
      for(j in i:length(ra)){
        print(paste0("j: ", j))

        if(ra[[j]] >= min_thresh & !is.na(ra[[j]])){

          events[[j]] = event_counter
          if(j == length(ra)){
            return(events)
          }
          l = l +1
        }else{
          # events[(j - l):(j-1)] = event_counter
          event_counter = event_counter + 1
          i = j
          break
        }
      }
      i = j
    }
  }
  return(events)
}
