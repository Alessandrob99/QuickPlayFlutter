
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


class Prenotazione
{

  String id;
  String prenotatore;
  DateTime oraInizio;
  DateTime oraFine;

  Prenotazione(this.id, this.prenotatore, this.oraInizio, this.oraFine);
}


class Club{
    int id;
    String nome;
    String telefono;
    String email;
    bool docce;
    double lat;
    double lng;

    Club(this.id, this.nome, this.telefono, this.email, this.docce, this.lat,
      this.lng);
}


class LayoutInfo {
  String circolo;
  String campo;
  String data;
  String orainizio;
  String oraFine;
  String codice;

  LayoutInfo(this.circolo, this.campo, this.data, this.orainizio,
      this.oraFine, this.codice);

}

class Court{
  int n_c;
  int codClub;
  String superficie;
  String sport;
  int prezzo;
  bool riscaldamento;
  bool coperto;

  Court(this.n_c, this.codClub, this.superficie, this.sport, this.prezzo,
      this.riscaldamento, this.coperto);
}