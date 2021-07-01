#' Get Stations by Voronoi
#'
#'
#'@export

get_stations_by_voronoi = function(position, station_sf) {

  # vor[[1]] --> Polygons
  # vor[[2]] --> Centroids

  # get the voronoi polygons of the stations
  vor = make_voronoi(station_sf)

  # check in which voronoi polygon each point is
  sg = unlist(st_within(position, vor[[1]])) # gets the indices of the voronoi polygons

  # get the station indices
  stations_idx = sapply(sg, function(x){
    log = lengths(st_within(vor[[2]], vor[[1]][x,]))
    idx = which(log > 0)
    idx
  })

  # select the stations
  stations = vor[[2]][stations_idx, ]

  # turn each row (station) into a dataframe and put it in a list
  stations_list = lapply(1:nrow(stations), function(i) {
    stations[i, ]
  })

  # append the corresponding station to each point in space
  position[["stations"]] = vector("list", length = nrow(position))
  for (i in 1:nrow(position)) {
    position[["stations"]][[i]] = stations_list[[i]]
  }


  return(position)

}
