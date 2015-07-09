#' Developing descriptive graphs on youtube videos
#'
#' for the given video id a graph on likes, dislikes, comments, shares and views on
#' youtube and facebook
#'
#' @param vid a character scalar that contains the vedio id
#' @return a barchart which containts the statistics on the video
#' @export
#' @import RMySQL
#' @import rjson


getgraph<-function(vid)
{
  drv=dbDriver("MySQL")
  con=dbConnect(drv, user ="root", dbname="youtube_data")
  data=dbGetQuery(con, "SELECT * FROM iit_youtube_long")
  #dbDisconnect(con)
  #dbUnloadDriver(drv)
  #vid="0FfG_5JBVBQ"
  graph=as.vector(data[data["v_id"]==vid,])
  dj=toJSON(graph)
}
