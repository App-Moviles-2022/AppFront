class User {
  String id;
  String name;
  String pass;
  String type;
  String lastName;
  String userNick;
  String ruc;
  String dni;
  String phone;
  String email;
  String urlToImageBackground;
  String urlToImageProfile;
  int districtId;
  User(
      { required this.id,
        required this.name,
        required this.pass,
        required this.type,
        required this.lastName,
        required this.userNick,
        required this.ruc,
        required this.dni,
        required this.phone,
        required this.email,
        required this.urlToImageBackground,
        required this.urlToImageProfile,
        required this.districtId,
      });

  factory User.fromJson(Map json) {
    return User(
        id: json["id"],
        name: json["name"],
        pass: json["pass"],
        type: json["type"],
        lastName: json["lastName"],
        userNick: json["userNick"],
        ruc: json["ruc"],
        dni: json["dni"],
        phone: json["phone"],
        email: json["email"],
        urlToImageBackground:json["urlToImageBackground"],
        urlToImageProfile:json["urlToImageProfile"],
        districtId: json["districtId"]
    );
  }
}
