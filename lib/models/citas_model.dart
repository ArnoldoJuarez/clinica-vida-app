class Cita {
  final String citaId;
  final String doctorId;
  final String nombreDoctor;
  final String pacienteId;
  final String nombrePaciente;
  final DateTime fechaHora;
  final String estado;
  final String notas;
  final String especialidadDoctor;
  final String ubicacionCita;
  final String metodoPago;
  final int duracionCita;
  final double costoCita;
  final String estadoPago;
  final DateTime fechaCreacion;

  Cita({
    required this.citaId,
    required this.doctorId,
    required this.nombreDoctor,
    required this.pacienteId,
    required this.nombrePaciente,
    required this.fechaHora,
    required this.estado,
    required this.notas,
    required this.especialidadDoctor,
    required this.ubicacionCita,
    required this.metodoPago,
    required this.duracionCita,
    required this.costoCita,
    required this.estadoPago,
    required this.fechaCreacion,
  });

  // Método para convertir la clase a un mapa
  Map<String, dynamic> toMap() {
    return {
      'citaId': citaId,
      'doctorId': doctorId,
      'nombreDoctor': nombreDoctor,
      'pacienteId': pacienteId,
      'nombrePaciente': nombrePaciente,
      'fechaHora': fechaHora.toIso8601String(),
      'estado': estado,
      'notas': notas,
      'especialidadDoctor': especialidadDoctor,
      'ubicacionCita': ubicacionCita,
      'metodoPago': metodoPago,
      'duracionCita': duracionCita,
      'costoCita': costoCita,
      'estadoPago': estadoPago,
      'fechaCreacion': fechaCreacion.toIso8601String(),
    };
  }

  // Método para crear una instancia de la clase a partir de un mapa
  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      citaId: map['citaId'],
      doctorId: map['doctorId'],
      nombreDoctor: map['nombreDoctor'],
      pacienteId: map['pacienteId'],
      nombrePaciente: map['nombrePaciente'],
      fechaHora: DateTime.parse(map['fechaHora']),
      estado: map['estado'],
      notas: map['notas'],
      especialidadDoctor: map['especialidadDoctor'],
      ubicacionCita: map['ubicacionCita'],
      metodoPago: map['metodoPago'],
      duracionCita: map['duracionCita'],
      costoCita: (map['costoCita'] as num).toDouble(),
      estadoPago: map['estadoPago'],
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
    );
  }
}