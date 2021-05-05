
#' chck the format for each station. Not really important...
#' @param station A dataframe for one specific station
check_rainfall_data = function(station){

  c = ncol(station)
  if(!c == 4){
    stop("This station does not have 4 columns")
  }else{
    return(invisible(NULL))
  }
}
