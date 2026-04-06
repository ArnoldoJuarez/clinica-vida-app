import 'package:clinica_vida_app/models/citas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CitaController {
  final List<Cita> _citas = [];

  List<Cita> get citas => _citas;

  void agregarCita(Cita cita) {
    _citas.add(cita);
  }

  Cita? obtenerCitaPorId(String id) {
    return _citas.firstWhere(
      (cita) => cita.citaId == id,
      orElse: () =>List.empty() [0],
    );
  }

  void eliminarCita(String id) {
    _citas.removeWhere((cita) => cita.citaId == id);
  }

  Future<void> guardarCitaEnFirestore(Cita cita) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(cita.citaId)
        .set(cita.toMap());
  }

  Future<void> actualizarCitaEnFirestore(Cita cita) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(cita.citaId)
        .update(cita.toMap());
  }

  Future<void> eliminarCitaDeFirestore(String id) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(id)
        .delete();
  }


  Future<List<Cita>> obtenerCitasDesdeFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('citas')
        .get();

    return querySnapshot.docs.map((doc) => Cita.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<Cita>> obtenerCitasPorPacienteId(String pacienteId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('citas')
        .where('pacienteId', isEqualTo: pacienteId)
        .get();

    return querySnapshot.docs.map((doc) => Cita.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<Cita>> obtenerCitasPorDoctorId(String doctorId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('citas')
        .where('doctorId', isEqualTo: doctorId)
        .get();

    return querySnapshot.docs.map((doc) => Cita.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}