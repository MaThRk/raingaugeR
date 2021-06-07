#' Choose the station for a given landslide-position
#'
#' @importFrom sf st_as_sf st_within st_drop_geometry
#'
#' @param n Number of Stations (Voronoi only uses 1)
#'
#' @export

select_station = function(position = NULL,
                          method = "distance",
                          n = 3) {

    # get the station information
    station_info = get_station_information()

    # turn it into a sf object
    station_sf = st_as_sf(station_info, coords = c("easting", "northing"), crs=32632)

    # ------------------------------------------------------------------------
    # THE VORONOI APPROACH
    # If we use the Voroni approach we dont want to construct the voronoi polygons
    # for each landslide (when we pass a sf-object with more than one row)

    if (method == "voronoi") {

      # get the stations for each point
      position = get_stations_by_voronoi(position, station_sf)

      return(position)

    }else if(method == "topo"){

    # -------------------------------------------------------------------------
    # Other approach based on topographic values

    }else if(method == "compare"){

    # -------------------------------------------------------------------------
    # Based on comparison with raster data data


    } else if (method == "distance") {

      # the list to store the n stations for each position
      position[["stations"]] = vector("list", length = nrow(position))

      # for each point get the n stations
      for (i in 1:nrow(position)) {
        stations_position = get_station_by_distance(position[i, ], station_sf)
        position[["stations"]][[i]] = stations_position

      }

      return(position)

    }
}



