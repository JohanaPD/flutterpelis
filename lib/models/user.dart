class User {
   int? id;
  final String usuario;
  final String passw;

  User({this.id, required this.usuario, required this.passw});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'usuario': usuario,
      'passw': passw,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      usuario: map['usuario'] as String,
      passw: map['passw'] as String,
    );
  }
   factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    usuario: json["usuario"],
    passw: json["passw"],
  );

   Map<String, dynamic> toJson() => {
    "id": id,
    "usuario": usuario,
    "passw": passw
  };
}
