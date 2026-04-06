
import 'package:clinica_vida_app/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorController {
  final List<Doctor> _doctores = [];

  List<Doctor> get doctores => _doctores;

  void agregarDoctor(Doctor doctor) {
    _doctores.add(doctor);
  }

  Doctor? obtenerDoctorPorId(String id) {
    return _doctores.firstWhere(
      (doctor) => doctor.id == id,
     // orElse: () =>null, // Asegúrate de que el tipo de retorno sea Doctor?
    );
  }

  void eliminarDoctor(String id) {
    _doctores.removeWhere((doctor) => doctor.id == id);
  }

Future<void> guardarDoctorEnFirestore(Doctor doctor) async {
    await FirebaseFirestore.instance
        .collection('doctores')
        .doc(doctor.id)
        .set(doctor.toMap());
  }

  Future<void> actualizarDoctorEnFirestore(Doctor doctor) async {
    await FirebaseFirestore.instance
        .collection('doctores')
        .doc(doctor.id)
        .update(doctor.toMap());
  }

  Future<void> eliminarDoctorDeFirestore(String id) async {
    await FirebaseFirestore.instance
        .collection('doctores')
        .doc(id)
        .delete();
  }

  Future<List<Doctor>> obtenerDoctoresDesdeFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('doctores')
        .get();

    return querySnapshot.docs.map((doc) => Doctor.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<Doctor>> obtenerDoctoresPorEspecialidad(String especialidad) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('doctores')
      .where('especialidad', isEqualTo: especialidad)
      .get();

  return querySnapshot.docs.map((doc) => Doctor.fromMap(doc.data() as Map<String, dynamic>)).toList();
}  

Future<List<String>> obtenerHorariosDisponibles(String doctorId) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('doctores')
      .doc(doctorId)
      .get();

  if (docSnapshot.exists) {
    Doctor doctor = Doctor.fromMap(docSnapshot.data() as Map<String, dynamic>);
    return doctor.horarioAtencion.keys.toList();
  } else {
    return [];
  }
}


}