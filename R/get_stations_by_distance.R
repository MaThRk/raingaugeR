#' Select station for point in space
#'
#' For a given location select the n nearest stations


get_station_by_distance = function(position, station_sf){

      # for each landslide compute the distance to each station
      # (there are fast ways to do this)
      dis = st_distance(position, station_sf)
      station_idx = order(dis)[1:n]

      # get the n stations
      stations = station_sf[station_idx, ]
      stations[["distance"]] = dis[station_idx]

      # return the n stations for this point
      return(stations)

}

