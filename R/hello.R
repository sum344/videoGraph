#' Developing descriptive graphs on youtube videos
#'
#' for the given video id a graph on likes, dislikes, comments, shares and views on
#' youtube and facebook
#'
#' @param vid a character scalar that contains the vedio id
#' @return a barchart which containts the statistics on the video
#' @export
#' @import RMySQL


getgraph<-function(vid)
{
  drv=dbDriver("MySQL")
  con=dbConnect(drv, user ="root", dbname="youtube_data")
  data=dbGetQuery(con, "SELECT * FROM iit_youtube_long")
  #dbDisconnect(con)
  #dbUnloadDriver(drv)
  #vid="0FfG_5JBVBQ"
  graph=as.vector(data[data["v_id"]==vid,])
  youtube=as.numeric(c(graph["v_likeCount"], graph["v_dislikeCount"], graph["v_viewCount"], "0",graph["v_commentCount"]))
  facebook=as.numeric(c(graph["fb_like_count"],"0", "0", graph["fb_share_count"], graph["fb_comment_count"]))
  mat=cbind(youtube, facebook)
  rownames(mat)=c("likes", "dislikes", "views", "shares", "comments")
  mat=mat/1000000
  png("temp.png")
  barplot(mat, main="stats", col=c("pale green","red", "blue", "orange", "yellow"), legend=c("likes", "dislikes", "views", "shares", "comments"))
  dev.off()
}
