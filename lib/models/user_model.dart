class UserModel {
  String uid;
  String email;
  String nombre;
  String apellido;
  String password;
  DateTime fechaNacimiento;
  String sexo;
  String telefono;
  String dui;
  String direccion;
  String departamento;
  String tipoUsuario;

  UserModel({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.apellido,
    required this.password,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.dui,
    required this.direccion,
    required this.departamento,
    required this.tipoUsuario,
  });

  // Método para convertir el objeto a un mapa (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'password': password,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'sexo': sexo,
      'telefono': telefono,
      'dui': dui,
      'direccion': direccion,
      'departamento': departamento,
      'tipoUsuario': tipoUsuario,
    };
  }

  // Método para crear un objeto desde un mapa (de Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      password: map['password'],
      fechaNacimiento: DateTime.parse(map['fechaNacimiento']),
      sexo: map['sexo'],
      telefono: map['telefono'],
      dui: map['dui'],
      direccion: map['direccion'],
      departamento: map['departamento'],
      tipoUsuario: map['tipoUsuario'],
    );
  }
}
