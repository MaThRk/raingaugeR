#' Make voroni polygons
#'
#'
#'
#'
#'
#'
#'

make_voronoi = function(poly){

  mp = st_combine(poly)
  v  = st_voronoi(mp)
  v = st_collection_extract(v)
  centroids = st_centroid(poly)

  r = list("voroni" = v, "centroids" = centroids)

  return(r)

}
