class User{
   int userId;
  int id ;
  String title;
  String body;

  User({
     required this.userId,
    required this.id,
    required this.title,
    required this.body,
});
  factory User.fromJson(Map<String, dynamic> json)=> User(
   userId: json['userId'],
   id: json['id'],
   title:json['title'],
   body: json['body'],
   );

}