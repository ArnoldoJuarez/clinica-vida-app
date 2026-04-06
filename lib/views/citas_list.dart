import 'package:clinica_vida_app/controllers/citas_controllers.dart';
import 'package:clinica_vida_app/models/citas_model.dart';
import 'package:flutter/material.dart';

class CitaListScreen extends StatelessWidget {
  final CitaController citaController = CitaController();

  CitaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Citas'),
      ),
      body: FutureBuilder<List<Cita>>(
        future: citaController.obtenerCitasDesdeFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay citas disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Cita cita = snapshot.data![index];
                return ListTile(
                  title: Text('Cita con el Dr. ${cita.doctorId}'),
                  subtitle: Text('Fecha: ${cita.fechaHora}'),
                  onTap: () {
                    // Navegar a la vista de detalles de la cita
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