class Doctor {
  final String id;
  final String nombre;
  final String especialidad;
  final String email;
  final String telefono;
  final String ubicacion;
  final String fotoPerfil;
  final Map<String, String> horarioAtencion;
  final List<String> diasNoDisponibles;
  final int duracionCita;
  final double costoCita;

  Doctor({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.email,
    required this.telefono,
    required this.ubicacion,
    required this.fotoPerfil,
    required this.horarioAtencion,
    required this.diasNoDisponibles,
    required this.duracionCita,
    required this.costoCita,
  });

  // Método para convertir la clase a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'especialidad': especialidad,
      'email': email,
      'telefono': telefono,
      'ubicacion': ubicacion,
      'fotoPerfil': fotoPerfil,
      'horarioAtencion': horarioAtencion,
      'diasNoDisponibles': diasNoDisponibles,
      'duracionCita': duracionCita,
      'costoCita': costoCita,
    };
  }

  // Método para crear una instancia de la clase a partir de un mapa
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      nombre: map['nombre'],
      especialidad: map['especialidad'],
      email: map['email'],
      telefono: map['telefono'],
      ubicacion: map['ubicacion'],
      fotoPerfil: map['fotoPerfil'],
      horarioAtencion: Map<String, String>.from(map['horarioAtencion']),
      diasNoDisponibles: List<String>.from(map['diasNoDisponibles']),
      duracionCita: map['duracionCita'],
      costoCita: (map['costoCita'] as num).toDouble(),
    );
  }
}



