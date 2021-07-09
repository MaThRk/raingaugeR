#' Wrapper-function to extract rainfall for one point
#'
#'
#' @export
get_rainfall_from_gauge = function(point = NULL,
                                   date_of_landslide = NULL,
                                   days_back = 10,
                                   select_station_by = "dist",
                                   n_stations = 2) {




  # -------------------------------------------------------------------------
  # Some input checking (do it well please...)

  # nothing null
  if(any(c(is.null(point), is.null(date_of_landslide), is.null(days_back), is.null(select_station_by), is.null(n_stations)))){
    stop("None of the inputs is supposed to be null...")
  }

  # sptial object has to be of class sf
  if(!inherits(point, "sf")){
    stop("Please use an object of class sf...")
  }

  # date
  if(!inherits(date_of_landslide, "Date")){
    stop("The passed date argument must be of class date... ")
  }

  # check if there are as many dates as landslides
  n_slide = nrow(point)
  n_date = length(date_of_landslide)
  if(!n_slide == n_date){
    stop("There must be one date for each landslide...")
  }

  # -------------------------------------------------------------------------
  # GET THE STATION
  # This has to be a list of stations! So the length of that list must equal the number of landslides

  if(! select_station_by %in% c("dist", "voronoi")){stop("[Raingauger] The method you provided is not (yet) implemented...")}

  if(select_station_by == "dist"){

    stations = get_station_by_distance(position = point,
                                       n = n_stations)
    # give it a unique id
    stations[["id"]] = 1:nrow(stations)

    # split it up
    stations = split(stations, stations$id)

  }else{
    stop("Yet to be implemented...")
  }


  # -------------------------------------------------------------------------
  # GET THE RAINFALL FOR THESE STATIONS

  # returns a list of lists of dataframes
  rainfall = map(stations, ~read_rainfall(station = .x$stations[[1]]$name_from_file,
                                          start_date = rep(.x$date, nrow(.x$stations[[1]])),
                                          end_date = rep(.x$date + days_back, nrow(.x$stations[[1]]))))


  # returns a list of dataframes
  rain_data = map(rainfall, function(x){

    data_avail = map(x,  function(y){
      val = y$data$data$data_avail
    })

    df = bind_rows(x, .id="name") %>%
      dplyr::select(data, name) %>%
      mutate(
        data_avail = data_avail
      ) %>%
      st_drop_geometry()

    df
  })


  # put the rainfall at the landslide data
  st = bind_rows(stations)
  st[["rain_data"]] = rain_data

  # -------------------------------------------------------------------------
  return(st)
  # return that mixture of everything

}
