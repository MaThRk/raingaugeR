#' Select station by distance
#'
#' @importFrom sf st_distance
#'
#'
#' For a given location select the n nearest stations
#' @export

get_station_by_distance = function(position, station_sf, n = 3) {

   for (i in 1:nrow(position)) {
      # for each landslide compute the distance to each station
      # (there are fast ways to do this)
      dis = st_distance(position[i,], station_sf)
      station_idx = order(dis)[1:n]

      # get the n stations
      stations = station_sf[station_idx, ]
      stations[["distance"]] = dis[station_idx]

      position[["stations"]][[i]] = stations

   }

   # return the n stations for this point
   return(position)

}
