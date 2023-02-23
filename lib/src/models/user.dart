class User {
  int? id;
  String? name;
  String? ocupation;
  String? cpf;
  String? phone;
  String? email;
  String? status;

  User(
      {this.id,
      this.name,
      this.ocupation,
      this.cpf,
      this.phone,
      this.email,
      this.status});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'ocupation': ocupation,
      'cpf': cpf,
      'phone': phone,
      'email': email,
      'status': status,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    ocupation = map['ocupation'];
    cpf = map['cpf'];
    phone = map['phone'];
    email = map['email'];
    status = map['status'];
  }
}
