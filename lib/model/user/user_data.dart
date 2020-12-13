class UserData {
//DocId
  final String userDataId;
//User identification
  final String userId;
  final String googleAuth;
//User display name visible to other users
  final String displayName;
//User profile picture download URL
  final String pictureDownloadURL;
//Cleaning stats
  final int trashCollected;
  final int pointsCreated;

  UserData({this.userId,this.userDataId,this.displayName,this.googleAuth,this.pictureDownloadURL,this.pointsCreated,this.trashCollected});
}