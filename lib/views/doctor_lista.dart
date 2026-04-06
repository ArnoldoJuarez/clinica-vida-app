import 'package:clinica_vida_app/controllers/doctor_controller.dart';
import 'package:clinica_vida_app/models/doctor_model.dart';
import 'package:clinica_vida_app/views/detalles_doctor.dart';
import 'package:flutter/material.dart';

class DoctorListScreen extends StatelessWidget {
  final String especialidad;
  final String userId;
  final String userName;
 // final String userType;
    final DoctorController doctorController = DoctorController();


  DoctorListScreen({super.key, 
    required this.especialidad,
    required this.userId,
    required this.userName,
    //required this.userType,
  });
 

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores de $especialidad'),
        
      ),
      body: FutureBuilder<List<Doctor>>(
        future: doctorController.obtenerDoctoresPorEspecialidad(especialidad),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay doctores disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Doctor doctor = snapshot.data![index];
                return ListTile(
                  leading: Image.network(doctor.fotoPerfil),
                  title: Text(doctor.nombre),
                  subtitle: Text(doctor.especialidad),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailScreen(
                          doctor: doctor,
                          pacienteId: userId,
                          pacienteNombre: userName,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
