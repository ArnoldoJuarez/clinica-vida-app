import 'package:clinica_vida_app/models/doctor_model.dart';
import 'package:clinica_vida_app/views/confirmar_cita.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;
  final String pacienteId;
  final String pacienteNombre;

  const DoctorDetailScreen({super.key, 
    required this.doctor,
    required this.pacienteId,
    required this.pacienteNombre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Doctor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                doctor.fotoPerfil,
                height: 100,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Especialidad: ${doctor.especialidad}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Email: ${doctor.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Teléfono: ${doctor.telefono}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Ubicación: ${doctor.ubicacion}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Duración de la cita: ${doctor.duracionCita} minutos',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Costo de la cita: \$${doctor.costoCita}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Horario de Atención:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...doctor.horarioAtencion.entries.map((entry) {
              return Text(
                '${entry.key}: ${entry.value}',
                style: const TextStyle(fontSize: 16),
              );
            // ignore: unnecessary_to_list_in_spreads
            }).toList(),
            const SizedBox(height: 8),
           /* const Text(
              'Días No Disponibles:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...doctor.diasNoDisponibles.map((dia) {
              return Text(
                dia,
                style: const TextStyle(fontSize: 16),
              );  
            }).toList(), */
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleAppointmentScreen(
                      doctor: doctor,
                      pacienteId: pacienteId,
                      pacienteNombre: pacienteNombre,
                    ),
                  ),
                );
              },
              child: const Text('Programar Cita'),
            ),
          ],
        ),
      ),
    );
  }
}