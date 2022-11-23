class UserAcceptTermsList{
  int id;
  int userId;


  UserAcceptTermsList(this.id, this.userId);

  Map<String, dynamic> toMap(){
    return{
      'id': (id == 0)? null : id,
      'userId': userId,
     // 'idList':idList
    };
  }


}

