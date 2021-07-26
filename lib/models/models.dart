class User {
  String nome;
  String cognome;
  String email;
  String password;
  String telefono;

  User(this.nome, this.cognome, this.email, this.password, this.telefono);

  User.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        cognome = json['cognome'],
        email = json['email'],
        password = json['password'],
        telefono = json['telefono'];

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'cognome': cognome,
    'email': email,
    'password': password,
    'telefono': telefono,
  };
}
