//Model for single comment at defined trash point
class TrashPointComment {
//Timestamp
  DateTime creationDateTime;
//Comment data
  String pointCommentId;
  String pointCommentContent;
//Trash point data, pointName required for user comments section
  String pointName;
  String pointId;
//Creator Id
  String userId;

  TrashPointComment({this.pointId,this.pointCommentContent,this.userId,this.pointCommentId,this.pointName,this.creationDateTime});


}